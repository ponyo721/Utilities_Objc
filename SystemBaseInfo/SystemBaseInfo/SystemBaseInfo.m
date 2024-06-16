//
//  SystemBaseInfo.m
//  SystemBaseInfo
//
//  Created by 박병호 on 6/16/24.
//

#import "SystemBaseInfo.h"
#include <sys/utsname.h>
#import <sys/sysctl.h>

#define kVarSysInfoKeyCPUBrand  @"machdep.cpu.brand_string"

@implementation SystemBaseInfo

#pragma mark - public -
- (NSString *)getCPUBrandName {
    NSString * CPUName = nil;
    CPUName = [[NSString alloc]initWithString:[self parseBrandName:[self strControlEntry:kVarSysInfoKeyCPUBrand]]];
    return CPUName;
}

#pragma mark - private -
- (NSString *)strControlEntry:(NSString *)ctlKey {

    size_t size = 0;
    if ( sysctlbyname([ctlKey UTF8String], NULL, &size, NULL, 0) == -1 ) return nil;

    char *machine = calloc( 1, size );

    sysctlbyname([ctlKey UTF8String], machine, &size, NULL, 0);
    NSString *ctlValue = [NSString stringWithCString:machine encoding:[NSString defaultCStringEncoding]];

    free(machine); return ctlValue;
}

- (NSString *)parseBrandName:(NSString *)brandName {
//    NSLog(@"brandName : %@", brandName);

    if ( !brandName ) return nil;

    NSMutableArray *newWords = [NSMutableArray array];
    NSString *strCopyRight = @"r", *strTradeMark = @"tm", *strCPU = @"CPU";

    NSArray *words = [brandName componentsSeparatedByCharactersInSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]];

    for ( NSString *word in words ) {

        if ( [word isEqualToString:strCPU] )       break;
        if ( [word isEqualToString:@""] )          continue;
        if ( [word.lowercaseString isEqualToString:strCopyRight] ) continue;
        if ( [word.lowercaseString isEqualToString:strTradeMark] ) continue;

        if ( [word length] > 0 ) {

            NSString *firstChar = [word substringToIndex:1];
            if ( NSNotFound != [firstChar rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location ) continue;

            [newWords addObject:word];

    } } return [newWords componentsJoinedByString:@" "];
}

@end

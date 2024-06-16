//
//  FileTransferWindow.m
//  DataSplitSample
//
//  Created by 박병호 on 6/16/24.
//

#import "FileTransferWindow.h"
#import <Cocoa/Cocoa.h>

@implementation FileTransferWindow

- (void)openFileSendWindow{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSOpenPanel* openDlg = [NSOpenPanel openPanel];
        [openDlg setCanChooseFiles:YES];
        [openDlg setCanChooseDirectories:YES];
        [openDlg setAllowsMultipleSelection:YES];
        
        if([openDlg runModal] == NSModalResponseOK ){
            NSMutableArray *selectedFileList = [NSMutableArray array];
            
            for( NSURL* URL in [openDlg URLs] ){
                [selectedFileList addObject:[URL path]];
            }
            
            if(selectedFileList.count == 1){
                [self.delegate actionFileTransferWindowConfirm:selectedFileList.firstObject];
            }
        }
    });
}

@end

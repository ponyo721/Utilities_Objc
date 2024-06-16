//
//  AppDelegate.m
//  DataSplitSample
//
//  Created by 박병호 on 6/16/24.
//

#import "AppDelegate.h"
#import "FileTransferWindow.h"

@interface AppDelegate () <FileTransferWindowDelegate, NSWindowDelegate>{
    FileTransferWindow *_file_transfer_window;
    dispatch_queue_t _file_read_queue;
}

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self.window setLevel:NSModalPanelWindowLevel];
    [self.window setDelegate:self];
    
    _file_read_queue = dispatch_queue_create("com.bhpark.data.split.sample.file.read.queue", DISPATCH_QUEUE_CONCURRENT);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

#pragma mark - ui -

- (IBAction)actionFileSendBtn:(id)sender {
    
    if(_file_transfer_window == nil){
        _file_transfer_window = [[FileTransferWindow alloc] init];
        [_file_transfer_window setDelegate:self];
    }
    [_file_transfer_window openFileSendWindow];
}

#pragma mark - FileTransferWindowDelegate -

- (void)actionFileTransferWindowConfirm:(NSString *)filePath{
    NSLog(@"filePath : %@", filePath);
    
    if([self readFile:filePath])
        NSLog(@"readFile success");
    else
        NSLog(@"readFile fail");
}

#pragma mark - NSWindowDelegate -

- (void)windowWillClose:(NSNotification *)notification{
    [NSApp terminate:nil];
}

#pragma mark - private -

- (BOOL)readFile:(NSString*)filePath{
    NSLog(@"readFile");
    
    __block NSUInteger totolFileSize = 0;
    __block NSUInteger offset = 0; // 시작 위치
    __block NSUInteger bufferSize = 1024;
    __block NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    
    if (fileHandle == nil) {
        NSLog(@"파일을 열 수 없습니다.");
        return NO;
    }
    
    totolFileSize = fileHandle.seekToEndOfFile;
    NSLog(@"totolFileSize : %ld", totolFileSize);
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(_file_read_queue, ^{
        
        while(offset < totolFileSize){
            @autoreleasepool {
                
                [fileHandle seekToFileOffset:offset];
                NSData *data = [fileHandle readDataOfLength:bufferSize];

                NSLog(@"split data size : %ld", data.length);
                
                offset += bufferSize;
            }
        }
        dispatch_semaphore_signal(sem);
    });
    dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC));
    
    return YES;
}

@end

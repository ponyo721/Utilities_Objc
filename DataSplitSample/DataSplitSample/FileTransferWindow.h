//
//  FileTransferWindow.h
//  DataSplitSample
//
//  Created by 박병호 on 6/16/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FileTransferWindowDelegate <NSObject>
- (void)actionFileTransferWindowConfirm:(NSString *)filePath;
@end

@interface FileTransferWindow : NSObject
@property (nonatomic) id<FileTransferWindowDelegate> delegate;
- (void)openFileSendWindow;
@end

NS_ASSUME_NONNULL_END

// Copyright 2015-present 650 Industries. All rights reserved.

#import <ABI46_0_0EXFileSystem/ABI46_0_0EXSessionResumableDownloadTaskDelegate.h>

@interface ABI46_0_0EXSessionResumableDownloadTaskDelegate ()

@property (strong, nonatomic, readonly) ABI46_0_0EXDownloadDelegateOnWriteCallback onWriteCallback;
@property (weak, nonatomic) ABI46_0_0EXTaskHandlersManager *manager;
@property (strong, nonatomic) NSString *uuid;

@end

@implementation ABI46_0_0EXSessionResumableDownloadTaskDelegate

- (instancetype)initWithResolve:(ABI46_0_0EXPromiseResolveBlock)resolve
                         reject:(ABI46_0_0EXPromiseRejectBlock)reject
                       localUrl:(NSURL *)localUrl
             shouldCalculateMd5:(BOOL)shouldCalculateMd5
                onWriteCallback:(ABI46_0_0EXDownloadDelegateOnWriteCallback)onWriteCallback
                resumableManager:(ABI46_0_0EXTaskHandlersManager *)manager
                           uuid:(NSString *)uuid;
{
  if (self = [super initWithResolve:resolve
                             reject:reject
                           localUrl:localUrl
                 shouldCalculateMd5:shouldCalculateMd5]) {
    _onWriteCallback = onWriteCallback;
    _manager = manager;
    _uuid = uuid;
  }
  return self;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
  [super URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
  [_manager unregisterTask:_uuid];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
  if (error) {
    // The task was paused by us. So, we shouldn't throw.
    if (error.code == NSURLErrorCancelled) {
      self.resolve([NSNull null]);
    } else {
      self.reject(@"ERR_FILESYSTEM_CANNOT_DOWNLOAD",
                  [NSString stringWithFormat:@"Unable to download file: %@", error.description],
                  error);
    }
  }

  [_manager unregisterTask:_uuid];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                           didWriteData:(int64_t)bytesWritten
                                      totalBytesWritten:(int64_t)totalBytesWritten
                              totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
  if (_onWriteCallback && bytesWritten > 0) {
    _onWriteCallback(downloadTask, bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
  }
}

@end

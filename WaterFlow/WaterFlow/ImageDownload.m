//
//  ImageDownload.m
//
//  Created by apple on 15/9/11.
//

#import "ImageDownload.h"


@interface ImageDownload ()<NSURLConnectionDataDelegate>

@property (nonatomic, retain)NSMutableData *receiveData;// 在延展里面定义一个属性用来存放下载的数据

@end


@implementation ImageDownload

- (void)dealloc
{
    [_receiveData release];
    // 对Block类型的变量进行释放
    Block_release(_successBlock);
    Block_release(_errorBlock);
    [super dealloc];
}

-(NSMutableData *)receiveData
{
    if (_receiveData == nil) {
        self.receiveData = [NSMutableData dataWithCapacity:0];
    }
    return _receiveData;
}



// 初始化方法，需要外界提供对应的网址
- (instancetype)initWithURLStr:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:15];
        [[[NSURLConnection alloc]initWithRequest:request delegate:self] autorelease];
    }
    return self;
}

// 便利构造器方法 方便外界使用
+ (ImageDownload *)imageDownloadWithURLStr:(NSString *)urlStr
{
    ImageDownload *imageDownload = [[ImageDownload alloc]initWithURLStr:urlStr ];
    return [imageDownload autorelease];

}

// 将接收到的数据进行拼接
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 拼接数据
    [self.receiveData appendData:data];
}


// 数据下载成功后 调用外界成功的Block方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [UIImage imageWithData:self.receiveData];
    self.successBlock(self,image);
}
// 下载失败后，同样调用外界失败的Block方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.errorBlock(self,error);
}


@end

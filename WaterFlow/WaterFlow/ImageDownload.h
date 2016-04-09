//
//  ImageDownload.h
//
//  Created by apple on 15/9/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class ImageDownload;
//定义一个名叫SuccessBlock的block
typedef void(^SuccessBlock)(ImageDownload *imageDownload, UIImage *image);
//定义一个名叫ErrorBlock的block
typedef void(^ErrorBlock)(ImageDownload *imageDownload, NSError *error);


@interface ImageDownload : NSObject
// 定义block为属性的时候 一定要用copy 原因在于 block定义完后 本身是在栈区或者全局区，不在堆区。当定义成属性的时候，需要copy一下 将其拷贝到堆区
@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) ErrorBlock errorBlock;





// 初始化方法，需要外界提供对应的网址
- (instancetype)initWithURLStr:(NSString *)urlStr;

// 便利构造器方法 方便外界使用
+ (ImageDownload *)imageDownloadWithURLStr:(NSString *)urlStr;
@end

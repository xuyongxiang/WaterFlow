//
//  ImageModel.m
//  WaterFlow
//
//  Created by apple on 15/9/17.
//

#import "ImageModel.h"
#import "ImageDownload.h"
@implementation ImageModel

-(void)dealloc
{

    [_picture release];
    [_height release];
    [_width release];
    [super dealloc];
    
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"thumbURL"]) {
        ImageDownload * imageDownload = [[ImageDownload alloc]initWithURLStr:value];
        imageDownload.successBlock = ^(ImageDownload *imageDownload, UIImage *image)
        {
            self.picture = image;
        };
        imageDownload.errorBlock = ^(ImageDownload *imageDownload, NSError * error)
        {
            NSLog(@"%@",error);
        };

    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end

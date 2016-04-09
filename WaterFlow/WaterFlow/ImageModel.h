//
//  ImageModel.h
//  WaterFlow
//
//  Created by apple on 15/9/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageModel : NSObject
@property(nonatomic,copy)NSString * width;
@property(nonatomic,copy)NSString * height;
@property(nonatomic,retain)UIImage * picture;
@end

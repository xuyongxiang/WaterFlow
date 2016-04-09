//
//  CustomCell.h
//  WaterFlow
//
//  Created by apple on 15/9/17.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@interface CustomCell : UICollectionViewCell
@property (nonatomic ,retain,readonly) UIImageView * pictureView;
-(void)configureCellWithModel:(ImageModel*)imageModel;
@end

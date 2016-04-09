//
//  CustomCell.m
//  WaterFlow
//
//  Created by apple on 15/9/17.
//

#import "CustomCell.h"
#import "ImageDownload.h"

@implementation CustomCell
-(void)dealloc
{
    [_pictureView  release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        _pictureView = [[UIImageView alloc]initWithFrame:self.bounds];
       
        [self.contentView addSubview:_pictureView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _pictureView.frame = self.bounds;
}

-(void)configureCellWithModel:(ImageModel*)imageModel
{
    self.pictureView.image = imageModel.picture;
}
@end

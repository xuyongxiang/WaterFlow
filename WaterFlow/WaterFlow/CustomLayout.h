//
//  CustomLayout.h
//  WaterFlow
//
//  Created by apple on 15/9/17.
//

#import <UIKit/UIKit.h>
@class CustomLayout;
@protocol CustomLayoutDelegate <NSObject>

-(CGSize)collectionView :(UICollectionView * )collectionView layout:(CustomLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CustomLayout : UICollectionViewFlowLayout

@property(nonatomic,assign)id<CustomLayoutDelegate>delegate;
//自定义初始化方法，参数由外界定义一共有几列
-(instancetype)initWithNumberOfColumns:(NSUInteger)columns;



@end

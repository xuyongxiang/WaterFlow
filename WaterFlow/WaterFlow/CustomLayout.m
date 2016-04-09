//
//  CustomLayout.m
//  WaterFlow
//
//  Created by apple on 15/9/17.
//

#import "CustomLayout.h"

@interface CustomLayout  ()
@property (nonatomic ,retain) NSMutableArray * frameArr;//存放每一列的frame
@property (nonatomic ,retain) NSMutableArray * attributesArr;//存放每一个item的属性
@end

@implementation CustomLayout

{
    NSUInteger _numofCloumns;//一共有多少列
}

-(void)dealloc
{
    [_frameArr release];
    [_attributesArr release];
    [super dealloc];
}


-(NSMutableArray *)attributesArr
{
    if (_attributesArr == nil ) {
        self.attributesArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _attributesArr;
}

-(instancetype)initWithNumberOfColumns:(NSUInteger)columns
{
    self = [super init];
    if (self) {
        _numofCloumns = columns;
    }
    return self;
}

-(NSMutableArray *)frameArr
{
    if (_frameArr == nil ) {
        self.frameArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _frameArr;
}
//准备每个item存放的位置
-(void)prepareLayout
{
    [super prepareLayout];
    [self.attributesArr removeAllObjects];
//    计算在当前列数下每个item的宽度；
    CGFloat  itemWith = self.collectionView.bounds.size.width/_numofCloumns;
//    通过for循环，在数组中每一列总得frame。由于开始时不知道frame的高度，height设置为0
    for (int i = 0 ; i < _numofCloumns; i ++)
    {
        CGRect frame = CGRectMake(itemWith * i, 0, itemWith, 0);
        NSValue * frameValue = [NSValue valueWithCGRect:frame];
        [self.frameArr addObject:frameValue];
    }
//    确定每个item存放的位置
    for (int i = 0 ; i < [self.collectionView numberOfItemsInSection:0]; i++)
    {
             NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGSize itemSize = [_delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        CGFloat height = itemSize.height * itemWith / itemSize.width;
//        获取所有列里面的最小frame
        NSUInteger  index = 0;
        CGRect frame = [self minimumFrameOfIndex:&index];
        CGFloat x = frame.origin.x;
        CGFloat y = frame.size.height;
        CGRect itemFrame = CGRectMake(x, y, itemWith, height);
//        将item的相关信息例如itemFrame，indexPath封装成一个  UICollectionViewLayoutAttributes对象中
        UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = itemFrame;
        [self.attributesArr addObject:attributes];
//        更新数组（由于新添加了item，所以需要修改数组对应元素）
        CGRect newFrame = CGRectMake(frame.origin.x, 0, itemWith, frame.size.height + height);
        [self.frameArr replaceObjectAtIndex:index withObject:[NSValue valueWithCGRect:newFrame] ];
        
    }
    
    
}

//返回所有列里面最小的frame。用于计算下一个item存放的位置的x ,y
-(CGRect)minimumFrameOfIndex:(NSUInteger *)index
{
    CGRect minFrame = CGRectMake(0, 0, 0, NSIntegerMax);
    for (int i = 0 ;  i < self.frameArr.count; i++)
    {
        NSValue * frameValue = self.frameArr[i];
        if (CGRectGetHeight(minFrame)> CGRectGetHeight([frameValue CGRectValue]) ){
            minFrame =[frameValue CGRectValue];
            *index = i ;
        }
    }
    return minFrame;
}


//返回数组里面最高的高度
-(CGFloat)maximumHeight
{
    CGFloat height = NSIntegerMin;
    for (int i = 0 ; i < self.frameArr.count; i ++)
    {
        NSValue * frameValue = self.frameArr[i];
        CGRect frame = [frameValue CGRectValue];
        if (CGRectGetHeight(frame)> height) {
            height = CGRectGetHeight(frame);
        }
    }
    return height;
}


//返回collectionView可滑动的区域
-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width, [self maximumHeight]);
}
//返回所有itemlayout属性
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArr;
}
@end

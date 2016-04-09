//
//  RootViewController.m
//  WaterFlow
//
//  Created by apple on 15/9/17.
//

#import "RootViewController.h"
#import "CustomLayout.h"
#import "ImageModel.h"
#import "CustomCell.h"
#import "ImageDownload.h"
@interface RootViewController ()<CustomLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)NSMutableArray * modelArr;
@end

@implementation RootViewController


-(NSMutableArray *)modelArr
{
    if (_modelArr == nil ) {
        self.modelArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _modelArr;
}

-(void)ConfigureData
{
    NSString * filePath = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    for (NSDictionary * dic in array) {
        ImageModel * imageModel = [[ImageModel alloc]init];
        [imageModel setValuesForKeysWithDictionary:dic];
        [self.modelArr addObject:imageModel];
        [imageModel release];

    }
    
    NSLog(@"%@",self.modelArr);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(CustomLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImageModel * imageModel = self.modelArr[indexPath.item];
    
    CGFloat width = imageModel.width.floatValue;
    CGFloat height = imageModel.height.floatValue;
    
    return CGSizeMake(width, height);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ConfigureData];
    CustomLayout * custonLayout = [[CustomLayout alloc]initWithNumberOfColumns:2];
    custonLayout.delegate = self;
    UICollectionView *  collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:custonLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:collectionView];
    [collectionView release];
   
    
    // Do any additional setup after loading the view.
}

#pragma dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.modelArr.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ImageModel * imageModel = self.modelArr[indexPath.item];
    if (imageModel.picture == nil ) {
          [imageModel addObserver:self forKeyPath:@"picture" options:(NSKeyValueObservingOptionNew) context:[indexPath retain]];
    }
  
    [cell configureCellWithModel:imageModel];
       return cell;
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
 
    NSIndexPath * indexPath = (NSIndexPath *)context;
    CustomCell * cell =(CustomCell *) [((UICollectionView *)self.view.subviews[0]) cellForItemAtIndexPath:indexPath];
    
    NSArray * visibleCell = [ ((UICollectionView *)self.view.subviews[0])  visibleCells];
    if ([visibleCell containsObject:cell]) {
        if (!change[@"new"] ) {
            cell.pictureView.image = nil;
        }
        else
        {
        cell.pictureView.image = change[@"new"];
        }
    }
    
    
    // 3 移除观察者
    [object removeObserver:self forKeyPath:keyPath context:context];
    
    [indexPath release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

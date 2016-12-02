//
//  ViewController.m
//  StudyFMDB
//
//  Created by limin on 16/11/30.
//  Copyright © 2016年 君安信（北京）科技有限公司. All rights reserved.
//

#import "MainViewController.h"
#import "LMListBar.h"
#import "LMArrow.h"
#import "LMDetailsList.h"
#import "LMDeleteBar.h"
#import "LMScroller.h"

//cell
#import "LMCollectionViewCell.h"


@interface MainViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) LMListBar *listBar;

@property (nonatomic,strong) LMDeleteBar *deleteBar;

@property (nonatomic,strong) LMDetailsList *detailsList;

@property (nonatomic,strong) LMArrow *arrow;

@property (nonatomic,strong) UICollectionView *mainCollection;

/* 上面的标签 */
@property(nonatomic,strong)NSMutableArray *listTop;
/* 下面的标签 */
@property(nonatomic,strong)NSMutableArray *listBottom;
@end
static NSString *cellid = @"collectionCellID";
@implementation MainViewController
-(NSMutableArray *)listTop
{
    if (!_listTop) {
        NSArray *temp = @[@"推荐",@"热点",@"杭州",@"社会",@"娱乐",@"科技",@"汽车",@"体育",@"订阅",@"财经",@"军事",@"国际",@"正能量",@"段子",@"趣图",@"美女",@"健康",@"教育",@"特卖",@"彩票",@"辟谣"];
        _listTop = [[NSMutableArray alloc] initWithArray:temp];
    }
    return _listTop;
}
-(NSMutableArray *)listBottom
{
    if (!_listBottom) {
        NSArray *temp = @[@"电影",@"数码",@"时尚",@"奇葩",@"游戏",@"旅游",@"育儿",@"减肥",@"养生",@"美食",@"政务",@"历史",@"探索",@"故事",@"美文",@"情感",@"语录",@"美图",@"房产",@"家居",@"搞笑",@"星座",@"文化",@"毕业生",@"视频"];
        _listBottom = [[NSMutableArray alloc] initWithArray:temp];
    }
    return _listBottom;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNaviBar];
    
    [self makeContent];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionView) name:@"TabChangedRefreshMainVC" object:nil];
    
}
-(void)setupNaviBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
}


-(void)makeContent
{
    __weak typeof(self) unself = self;
    
    if (!self.detailsList) {
        self.detailsList = [[LMDetailsList alloc] initWithFrame:CGRectMake(0, kListBarH-kScreenH, kScreenW, kScreenH-kListBarH)];
        self.detailsList.scrollsToTop = NO;
        self.detailsList.listAll = [NSMutableArray arrayWithObjects:self.listTop,self.listBottom, nil];
        self.detailsList.longPressedBlock = ^(){
            [unself.deleteBar sortBtnClick:unself.deleteBar.sortBtn];
        };
        self.detailsList.opertionFromItemBlock = ^(animateType type, NSString *itemName, int index){
            [unself.listBar operationFromBlock:type itemName:itemName index:index];
        };
        [self.view addSubview:self.detailsList];
    }
    
    if (!self.listBar) {
        self.listBar = [[LMListBar alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kListBarH)];
        self.listBar.scrollsToTop = NO;
        self.listBar.visibleItemList = self.listTop;
        self.listBar.arrowChange = ^(){
            if (unself.arrow.arrowBtnClick) {
                unself.arrow.arrowBtnClick();
            }
        };
        self.listBar.listBarItemClickBlock = ^(NSString *itemName , NSInteger itemIndex){
            [unself.detailsList itemRespondFromListBarClickWithItemName:itemName];
            //添加scrollview
            
            //移动到该位置
            unself.mainCollection.contentOffset =  CGPointMake(itemIndex * unself.mainCollection.frame.size.width, 0);
        };
        [self.view addSubview:self.listBar];
    }
    
    if (!self.deleteBar) {
        self.deleteBar = [[LMDeleteBar alloc] initWithFrame:self.listBar.frame];
        [self.view addSubview:self.deleteBar];
    }
    
    
    if (!self.arrow) {
        self.arrow = [[LMArrow alloc] initWithFrame:CGRectMake(kScreenW-kArrowW, 0, kArrowW, kListBarH)];
        self.arrow.arrowBtnClick = ^(){
            unself.deleteBar.hidden = !unself.deleteBar.hidden;
            [UIView animateWithDuration:kAnimationTime animations:^{
                CGAffineTransform rotation = unself.arrow.imageView.transform;
                unself.arrow.imageView.transform = CGAffineTransformRotate(rotation,M_PI);
                unself.detailsList.transform = (unself.detailsList.frame.origin.y<0)?CGAffineTransformMakeTranslation(0, kScreenH):CGAffineTransformMakeTranslation(0, -kScreenH);
                
            }];
        };
        [self.view addSubview:self.arrow];
    }
    
    if (!self.mainCollection) {
        //布局样式
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //定义每个collectionview的大小
        layout.itemSize = CGSizeMake(kScreenW, kScreenH-kListBarH-kNavHeight);
        //定义每个uicollectionview横向间距
        layout.minimumLineSpacing = 0;
        //定义每个uicollectionview纵向间距
        layout.minimumInteritemSpacing = 0;
        //滑动方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //创建collectionview
        self.mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kListBarH, kScreenW , kScreenH-kListBarH-kNavHeight) collectionViewLayout:layout];
        
        self.mainCollection.backgroundColor = [UIColor whiteColor];
        self.mainCollection.bounces = NO;
        self.mainCollection.pagingEnabled = YES;
        self.mainCollection.showsHorizontalScrollIndicator = NO;
        self.mainCollection.showsVerticalScrollIndicator = NO;
        self.mainCollection.delegate = self;
        self.mainCollection.dataSource = self;
        [self.mainCollection registerClass:[LMCollectionViewCell class] forCellWithReuseIdentifier:cellid];
        [self.view insertSubview:self.mainCollection atIndex:0];
        

    }
}
#pragma mark - 刷新页面
-(void)refreshCollectionView
{
    //取出最新的标签数据，刷新控制器
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [self.listTop removeAllObjects];
    [self.listBottom removeAllObjects];
    [self.listTop addObjectsFromArray:[userDefault valueForKey:topTitlesKey]];
    [self.listBottom addObjectsFromArray:[userDefault valueForKey:bottomTitlesKey]];
    //刷新
    [self.mainCollection reloadData];
    [self.mainCollection layoutIfNeeded];
    //重新计算偏移量
    for (int i=0; i<self.listTop.count; i++) {
        if ([self.listTop[i] isEqualToString:self.listBar.btnSelect.currentTitle]) {
            self.mainCollection.contentOffset = CGPointMake(i*kScreenW, 0);
            //再次点击当前被选中的。
            [self.listBar itemClickByScrollerWithIndex:i];
        }
    }
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listTop.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    
    cell.idStr = self.listTop[indexPath.row];
    return cell;
}
#pragma mark - 头部显示的内容
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
//    //轮播
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
//    view.backgroundColor = [UIColor redColor];
//    [headView addSubview:view];
//    return headView;
//}
#pragma mark -UIScrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.listBar itemClickByScrollerWithIndex:scrollView.contentOffset.x / self.mainCollection.frame.size.width];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

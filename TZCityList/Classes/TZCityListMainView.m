//
//  KLCityListMainView.m
//  KLCityListToolTest
//
//  Created by kinglian on 2018/4/27.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import "TZCityListMainView.h"
#import "KLCityListManage.h"
#import "TZCityListCollectionCell.h"
#import "KLCityModel.h"
#import "TZCityListMainHeaderView.h"


static NSString *KLCityListCollectionCellID = @"KLCityListCollectionCell";
@interface TZCityListMainView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,KLCityListCollectionCellDelegate>
@property (nonatomic ,strong) UICollectionView * myCollectionView; //
@property (nonatomic ,strong) TZCityListMainHeaderView * headerView; //

@property (nonatomic ,strong) NSMutableArray * dataSource; //数据源
@property (nonatomic ,strong) KLCityListManage * cityListManage; //
@property (nonatomic ,strong) NSMutableArray * parentIDArr; //
@property (nonatomic,strong) NSMutableDictionary *selectedCityDic;
@property (nonatomic ,strong) NSMutableArray * cityNameArr; //



@end
#define DB_NAME  @"City.db"
@implementation TZCityListMainView
- (instancetype)init{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (self = [super initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)]) {
//        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self prepareUI];
        [self makedateSourceWithSelectedIndex:0 CityCode:@"0" AndParentID:@"0086" SuccessBlcik:nil FinallBlock:nil];
        [self addSubview:self.myCollectionView];
    }
    return self;
}


- (void)prepareUI{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat myCollectionViewHeight = screenSize.height *0.56;
    CGFloat myCollecionViewY = screenSize.height-myCollectionViewHeight;
    self.myCollectionView.frame = CGRectMake(0, myCollecionViewY, screenSize.width, myCollectionViewHeight);
    
    CGFloat headerViewHeight = 65;
    CGFloat headerViewY = myCollecionViewY - headerViewHeight;
    _headerView = [[TZCityListMainHeaderView alloc] initWithFrame:CGRectMake(0, headerViewY, screenSize.width, headerViewHeight)];
    __weak typeof(self) weakSelf = self;
    _headerView.cancelBtnDidClickBlock = ^{
        [weakSelf dismissAction];
    };
    [self addSubview:_headerView];
}

- (void)makedateSourceWithSelectedIndex:(NSInteger)selectedIndex CityCode:(NSString *)cityCode AndParentID:(NSString *)parentID SuccessBlcik:(void(^)(void))successBlcik FinallBlock:(void(^)(void))finallBlock{
    
    if ([parentID isEqualToString:@"0086"]) {
        [self.parentIDArr addObject:@"86"];
        [self.dataSource addObject:[self.cityListManage getCityListWithParentID:parentID]];
        [self.myCollectionView reloadData];
        if (successBlcik) {
            successBlcik();
        }
        
        return;
    }
    
    
    if ([self.parentIDArr containsObject:parentID] && ![self.parentIDArr containsObject:cityCode]) {
        
        NSInteger currentIndex = [self.parentIDArr indexOfObject:parentID];
        
        for (NSInteger i = self.parentIDArr.count-1; i>=currentIndex; i--) {//清除至当前page的选中缓存
            NSString *key = self.parentIDArr[i];
            [self.selectedCityDic removeObjectForKey:key];
            if (i<self.cityNameArr.count) {
                [self.cityNameArr removeObjectAtIndex:i];
            }
        }
        //重新添加选中city
        [self.selectedCityDic setObject:[NSString stringWithFormat:@"%ld",selectedIndex] forKey:parentID];
        NSString *cityName = [(KLCityModel *)self.dataSource[currentIndex][selectedIndex] name];
        [self.cityNameArr addObject:cityName];
        
        NSArray *cityArr = [self.cityListManage getCityListWithParentID:cityCode];
        if (cityArr.count>0) {
            for (NSInteger i = self.dataSource.count-1;i>currentIndex;i--) {//清除至当前page前所有的城市层级列表
                [self.dataSource removeObjectAtIndex:i];
                [self.parentIDArr removeObjectAtIndex:i];
                
            }
            
            [self.dataSource addObject:cityArr];
            [self.parentIDArr addObject:cityCode];
            if (successBlcik) {
                
                successBlcik();
            }
            
        }else{//没有下级地址了
            if (finallBlock) {
                
                finallBlock();
            }
        }
        [self.myCollectionView reloadData];
        [self.myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
    
  
}
-(void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    CGSize mainScreenSize = [UIScreen mainScreen].bounds.size;
    
    CGRect headerEndFrame = self.headerView.frame;
    CGRect headerStartFrame = headerEndFrame;
    headerStartFrame.origin.y = mainScreenSize.height;
    
    
    CGRect collectionEndFrame = self.myCollectionView.frame;
    CGRect collectionStartFrame = collectionEndFrame;
    collectionStartFrame.origin.y = mainScreenSize.height+headerStartFrame.size.height;
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.headerView.frame = headerStartFrame;
    self.myCollectionView.frame = collectionStartFrame;
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.headerView.frame = headerEndFrame;
        self.myCollectionView.frame = collectionEndFrame;
    } completion:^(BOOL finished) {
        
    }];

   
}
- (void)dismissAction{
    
    CGSize mainScreenSize = [UIScreen mainScreen].bounds.size;
    
    CGRect headerEndFrame = self.headerView.frame;
    CGRect headerStartFrame = headerEndFrame;
    headerStartFrame.origin.y = mainScreenSize.height;
    
    CGRect collectionEndFrame = self.myCollectionView.frame;
    CGRect collectionStartFrame = collectionEndFrame;
    collectionStartFrame.origin.y = mainScreenSize.height+headerStartFrame.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.headerView.frame = headerStartFrame;
        self.myCollectionView.frame = collectionStartFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - KLCityListCollectionCellDelegate
- (void)cityCellDidSelected:(KLCityModel *)cityModel selectedIndex:(NSInteger)selectedIndex{
    __weak typeof(self) weakSelf = self;
    [self makedateSourceWithSelectedIndex:selectedIndex CityCode:[NSString stringWithFormat:@"%d",cityModel.code] AndParentID:[NSString stringWithFormat:@"%d",cityModel.parentId] SuccessBlcik:^{
        [weakSelf.headerView changeSelectedItemNameArr:self.cityNameArr isLast:NO];
    } FinallBlock:^{
        [weakSelf.headerView changeSelectedItemNameArr:self.cityNameArr isLast:YES];
        if (weakSelf.finishBlock) {
            weakSelf.finishBlock(weakSelf.cityNameArr);
        }
        [weakSelf dismissAction];
    }];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TZCityListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLCityListCollectionCellID forIndexPath:indexPath];
    NSString *selectedCityDicKey = self.parentIDArr[indexPath.row];
    NSString *selectedStr = self.selectedCityDic[selectedCityDicKey];
    cell.selectedIndexStr = selectedStr;
    cell.tableViewDataSource = self.dataSource[indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.myCollectionView]) {
        CGFloat width =  self.myCollectionView.bounds.size.width;
       int itemIndex = scrollView.contentOffset.x/width;
        [self.headerView changeSelectedSignViewCenterWithItemIndex:itemIndex];
    }
}

#pragma mark - Lazy Load
- (NSMutableArray *)dataSource{
    if (_dataSource) {
        return _dataSource;
    }
    _dataSource = [NSMutableArray array];
    return _dataSource;
}
- (NSMutableArray *)parentIDArr{
    if (_parentIDArr) {
        return _parentIDArr;
    }
    _parentIDArr = [NSMutableArray array];
    return _parentIDArr;
}
- (NSMutableDictionary *)selectedCityDic{
    if (_selectedCityDic) {
        return _selectedCityDic;
    }
    _selectedCityDic = [NSMutableDictionary dictionary];
    return _selectedCityDic;
}

- (NSMutableArray *)cityNameArr{
    if (_cityNameArr) {
        return _cityNameArr;
    }
    _cityNameArr = [NSMutableArray array];
    return _cityNameArr;
}
- (KLCityListManage *)cityListManage{
    if (_cityListManage) {
        return _cityListManage;
    }
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:DB_NAME ofType:nil];
    if (!dbPath) {
        return nil;
    }
    //    NSLog(@"path is %@",dbPath);
    //
    //    NSFileManager *fm = [NSFileManager defaultManager];
    //    BOOL isExist = [fm fileExistsAtPath:DB_NAME];
    //    if (!isExist) {
    //        NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:DB_NAME ofType:nil];
    //        [fm copyItemAtPath:backupDbPath toPath:dbPath error:nil];
    //    }else{
    //        NSLog(@"沙盒已经存在数据库文件");
    //    }
    
    FMDatabase * database = [ FMDatabase databaseWithPath:dbPath];
    if ([database open]) {
        _cityListManage = [[KLCityListManage alloc] initWithDatabase:database];
        return _cityListManage;
    }
    return nil;
}

- (UICollectionView *)myCollectionView{
    if (_myCollectionView) {
        return _myCollectionView;
    }
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat myCollectionViewHeight = screenSize.height *0.6;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(screenSize.width, myCollectionViewHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _myCollectionView.pagingEnabled = YES;
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    _myCollectionView.dataSource = self;
    _myCollectionView.delegate = self;
    [_myCollectionView registerClass:[TZCityListCollectionCell class] forCellWithReuseIdentifier:KLCityListCollectionCellID];
    return _myCollectionView;
}
@end

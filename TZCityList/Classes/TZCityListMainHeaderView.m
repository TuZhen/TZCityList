//
//  KLCityListMainHeaderView.m
//  KLCityListToolTest
//
//  Created by kinglian on 2018/5/4.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import "TZCityListMainHeaderView.h"
#define ColorNormal [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
#define ColorRed [UIColor colorWithRed:255/255.0 green:110/255.0 blue:110/255.0 alpha:1]

static CGFloat leftSpace = 15;
static CGFloat itemSuperViewHeight = 30;
@interface TZCityListMainHeaderView()
@property (nonatomic ,strong) UIButton *selectedCityBtn; //请选择按钮
@property (nonatomic ,strong) UIView * itemSuperView; //添加地址按钮的父视图层
@property (nonatomic ,strong) UIView * selectedSignView; //选中标记view
@property (nonatomic ,strong) NSArray * selectedItemNameArr; //地址名数组
@property (nonatomic ,strong)NSMutableArray *itemArr;//地址按钮数组
@property (nonatomic ,assign)BOOL isLast;//是否为最终级地址




@end
@implementation TZCityListMainHeaderView

- (instancetype)initWithFrame:(CGRect)frame WithSelectedColor:(UIColor *)selecterColor{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        titleLabel.text = @"请选择您的地址";
        [titleLabel sizeToFit];
        CGFloat titleLabelX = (frame.size.width-titleLabel.bounds.size.width) *0.5;
        titleLabel.frame = CGRectMake(titleLabelX, 8, titleLabel.bounds.size.width, titleLabel.bounds.size.height);
        [self addSubview:titleLabel];
        
        
        UIButton *cancelBtn = [[UIButton alloc] init];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        [cancelBtn sizeToFit];
        CGFloat cancelBtnWH = self.frame.size.height-itemSuperViewHeight;
        cancelBtn.frame = CGRectMake(self.bounds.size.width-cancelBtnWH, 3, cancelBtnWH, cancelBtnWH);
        [cancelBtn addTarget:self action:@selector(cancelBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        CGFloat bottomLineHeight = 0.8;
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, frame.size.height-bottomLineHeight, frame.size.width-leftSpace*2, bottomLineHeight)];
        bottomLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [self addSubview:bottomLine];
        
        UIView *itemSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(bottomLine.frame)-itemSuperViewHeight, frame.size.width, itemSuperViewHeight)];
        [self addSubview:itemSuperView];
        _itemSuperView = itemSuperView;
        
        
        UIButton *selectedCityBtn = [[UIButton alloc] init];
        selectedCityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [selectedCityBtn setTitleColor:selecterColor?:ColorRed forState:UIControlStateNormal];
        [selectedCityBtn setTitle:@"请选择" forState:UIControlStateNormal];
        [selectedCityBtn sizeToFit];
        selectedCityBtn.frame = CGRectMake(leftSpace, 0, selectedCityBtn.bounds.size.width, itemSuperViewHeight);
        _selectedCityBtn = selectedCityBtn;
        [self.itemSuperView addSubview:selectedCityBtn];
     
        UIView *selectedSingView = [[UIView alloc] init];
        selectedSingView.backgroundColor = selecterColor?:ColorRed;
        CGFloat selectedSingViewHeight = 0.8;
        selectedSingView.bounds = CGRectMake(0, 0, 40, selectedSingViewHeight);
        selectedSingView.center = CGPointMake(selectedCityBtn.center.x, itemSuperView.frame.size.height-selectedSingViewHeight);
        selectedSingView.layer.cornerRadius = selectedSingViewHeight*0.5;
        [self.itemSuperView addSubview:selectedSingView];
        _selectedSignView = selectedSingView;
        
       
    }
    return self;
}



- (void)changeSelectedItemNameArr:(NSArray<NSString *>*)itemNameArr isLast:(BOOL)isLast{
    _selectedItemNameArr = itemNameArr;
    _isLast = isLast;
    for (UIView *subView in self.itemSuperView.subviews) {
        if ([subView isEqual:self.selectedSignView] || [subView isEqual:self.selectedCityBtn]) {
            continue;
        }
        [subView removeFromSuperview];
    }
    [self.itemArr removeAllObjects];
    CGFloat lastItemMaxX = 0;
    CGFloat lastItemWidth =0;
    for (int i=0;i<_selectedItemNameArr.count;i++) {
        
        NSString *selectedItemName = _selectedItemNameArr[i];
        UIButton *item = [[UIButton alloc] init];
        item.titleLabel.font = [UIFont systemFontOfSize:14];
        [item setTitleColor:ColorNormal forState:UIControlStateNormal];
        [item setTitle:selectedItemName forState:UIControlStateNormal];
        [item sizeToFit];
        CGFloat itemX = lastItemMaxX+leftSpace;
        item.frame = CGRectMake(itemX, 0, item.bounds.size.width, itemSuperViewHeight);
        lastItemMaxX = itemX+item.bounds.size.width;
        lastItemWidth = item.bounds.size.width;
        [self.itemSuperView addSubview:item];
        [self.itemArr addObject:item];
        
    }
      self.selectedCityBtn.frame = CGRectMake(lastItemMaxX+leftSpace, 0, self.selectedCityBtn.bounds.size.width, itemSuperViewHeight);
    [self.itemArr addObject:self.selectedCityBtn];
    
    self.selectedCityBtn.hidden = isLast;
    if (isLast) {
        [self changeSelectedSignViewCenterWithItemIndex:_selectedItemNameArr.count-1];
    }else{
        [self changeSelectedSignViewCenterWithItemIndex:self.itemArr.count-1];
    }
    
}


- (void)changeSelectedSignViewCenterWithItemIndex:(NSInteger)itemIndex{
    CGFloat selectedSingViewHeight = 0.8;
    UIButton *item = self.itemArr[itemIndex];
    self.selectedSignView.center = CGPointMake(CGRectGetMaxX(item.frame)-item.bounds.size.width*0.5, self.itemSuperView.frame.size.height-selectedSingViewHeight);
}
#pragma mark - Acion
- (void)cancelBtnDidClick{
    if (self.cancelBtnDidClickBlock) {
        self.cancelBtnDidClickBlock();
    }
}

#pragma mark - Laze Load
-(NSMutableArray *)itemArr{
    if (_itemArr) {
        return _itemArr;
    }
    _itemArr = [NSMutableArray array];
    return _itemArr;
}

//- (void)chenge

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

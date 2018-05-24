//
//  MGCarouselView.m
//  MGCarouselCell
//
//  Created by haijun on 2018/5/21.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#import "MGCarouselView.h"
#import "MGCarouselCell.h"
#import "MGFlowLayout.h"
#import "MGCarouselBottomView.h"

static NSString *cellId = @"cellID";
@interface MGCarouselView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MGCarouselBottomView *bottomView;
@property (nonatomic, strong) MGFlowLayout *flowLayout;

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign)  NSInteger currentIndex;

@property(nonatomic, assign)  CGFloat width;
@property(nonatomic, assign) CGFloat edge;


@property (nonatomic, assign) CGFloat offsetX;
@end

@implementation MGCarouselView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCollectionView];
    }
    return self;
}

- (void)initCollectionView{
    
    _currentIndex = 0;
    
    _flowLayout = [[MGFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)-120, CGRectGetHeight(self.frame)-80);
    
    self.width = self.frame.size.width;
    self.edge = self.frame.size.width/2.0-((UICollectionViewFlowLayout*)_flowLayout).itemSize.width/2.0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-70) collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //_collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[MGCarouselCell class] forCellWithReuseIdentifier:cellId];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollsToTop = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(0, self.edge, 0, self.edge);
    //    _collectionView.decelerationRate = 10;
    [self addSubview:_collectionView];
    
    _bottomView = [[MGCarouselBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame), CGRectGetWidth(self.frame), 80)];
    [self addSubview:_bottomView];
    
}

- (void)setItems:(NSArray *)items{
    _items = items;
    _bottomView.model = _items[_currentIndex];
    [self.collectionView reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark 代理方法

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MGCarouselCell *cell = (MGCarouselCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSInteger itemIndex = indexPath.item%self.items.count;
    cell.itemModel = self.items[itemIndex];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

//系统动画停止是刷新当前偏移量_offer是我定义的全局变量
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _offsetX = scrollView.contentOffset.x;
}



-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (decelerate==NO) {
        _currentIndex=(int)((scrollView.contentOffset.x+self.width/2)/((self.width/2-self.edge)*2));
        
        
        [scrollView setContentOffset:CGPointMake(_currentIndex*(self.width/2.0-self.edge)*2-self.edge, scrollView.contentOffset.y) animated:YES];
        _bottomView.model = _items[_currentIndex];
        if (self.selectItemComplete) {
            self.selectItemComplete(_currentIndex);
        }
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    _currentIndex=(int)((scrollView.contentOffset.x+self.width/2)/((self.width/2-self.edge)*2));
    
    [scrollView setContentOffset:CGPointMake(_currentIndex*(self.width/2.0-self.edge)*2-self.edge, scrollView.contentOffset.y) animated:YES];
    _bottomView.model = _items[_currentIndex];
    if (self.selectItemComplete) {
        self.selectItemComplete(_currentIndex);
    }
}


//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    if (fabs(scrollView.contentOffset.x - _offsetX) > 20) {
//        [self scrollToNextPage:scrollView];
//    }
//}
//
//-(void)scrollToNextPage:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.x > _offsetX) {
//        int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 50)+1;
//        if (i >= _items.count) {
//            return;
//        }
//        NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
//        [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    }else{
//        int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 50)+1;
//        if (i < 1) {
//            return;
//        }
//        NSIndexPath * index =  [NSIndexPath indexPathForRow:i-1 inSection:0];
//        [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    }
//}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger index = indexPath.item%_items.count;
//    if (self.clickCellBlock) {
//        self.clickCellBlock(index);
//    }
//}

@end

//
//  MGCarouselView.m
//  MGCarouselCell
//
//  Created by haijun on 2018/5/21.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#import "MGCarouselView.h"
#import "MGCarouselCell.h"

static NSString *cellId = @"cellID";
@interface MGCarouselView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, assign) NSInteger scrollCounts;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign)  NSInteger currentIndex;

@property (nonatomic, assign) CGFloat offsetX;
@end

@implementation MGCarouselView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCollectionView];
        
        [self setupTimer];
    }
    return self;
}

- (void)initCollectionView{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[MGCarouselCell class] forCellWithReuseIdentifier:cellId];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollsToTop = NO;
    [self addSubview:_collectionView];

}

- (void)setItems:(NSArray *)items{
    _items = items;
    _scrollCounts = _items.count * 100;
    [self.collectionView reloadData];
}

- (void)autoScrollView{
    if (0 == _scrollCounts) return;
    NSInteger currentIndex = [self currentIndex];
    NSInteger targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
    
}

- (void)scrollToIndex:(NSInteger)targetIndex
{
    if (targetIndex >= _scrollCounts) {
        targetIndex = _scrollCounts * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSInteger)currentIndex
{
    if (CGRectGetWidth(_collectionView.frame) == 0 || CGRectGetHeight(_collectionView.frame) == 0) {
        return 0;
    }
    
    NSInteger index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    
    return MAX(0, index);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)-60, CGRectGetHeight(self.frame));
    self.collectionView.frame = self.bounds;
    
    if (_collectionView.contentOffset.x == 0 &&  _scrollCounts) {
        NSInteger targetIndex = _scrollCounts * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
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
    return _scrollCounts;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //[self setupTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (fabs(scrollView.contentOffset.x -_offsetX) > 10) {
        [self scrollToNextPage:scrollView];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (fabs(scrollView.contentOffset.x -_offsetX) > 10) {
        [self scrollToNextPage:scrollView];
    }
}

-(void)scrollToNextPage:(UIScrollView *)scrollView{
    if (!self.items.count) return;
    if (scrollView.contentOffset.x > _offsetX) {
        NSInteger currentIndex = [self currentIndex];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }else{
        NSInteger currentIndex = [self currentIndex];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _offsetX = scrollView.contentOffset.x;
}

- (void)makeScrollViewScrollToIndex:(NSInteger)index{
    [self invalidateTimer];
    if (0 == _scrollCounts) return;
    
    [self scrollToIndex:(int)(_scrollCounts * 0.5 + index)];
    [self setupTimer];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.frame)-60, CGRectGetHeight(self.frame));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.item%_items.count;
    if (self.clickCellBlock) {
        self.clickCellBlock(index);
    }
}

#pragma mark -定时器-
- (void)setupTimer
{
    [self invalidateTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

@end

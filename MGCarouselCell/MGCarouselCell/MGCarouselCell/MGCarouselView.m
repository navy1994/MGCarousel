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

@property (nonatomic, strong) NSMutableArray *carouselItems;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign)  NSInteger currentIndex;
@property (nonatomic, assign)  NSInteger lastIndex;
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
    [self.collectionView reloadData];
}

- (NSMutableArray *)carouselItems
{
    if (!_carouselItems) {
        _carouselItems = [NSMutableArray arrayWithArray:self.items];
        if (self.items.count > 0)
        {
            [_carouselItems insertObject:[self.items lastObject] atIndex:0];
            [_carouselItems addObject:self.items[0]];
        }
    }
    return _carouselItems;
}

- (void)autoScrollView{
    NSInteger currentIndex = self.currentIndex + 1;
    currentIndex = (currentIndex == self.carouselItems.count) ? 1 : currentIndex;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
    [self scrollToIndexPath:indexPath animated:YES];
    
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
{
    if (self.carouselItems.count > indexPath.row)
    {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    _flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)+80, CGRectGetHeight(self.frame));
    self.collectionView.frame = self.bounds;
    
    if (self.collectionView.contentOffset.x == 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self scrollToIndexPath:indexPath animated:NO];
        self.currentIndex = 1;
    }
}

#pragma mark 代理方法

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MGCarouselCell *cell = (MGCarouselCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.itemModel = self.carouselItems[indexPath.row];
//    cell.backgroundColor = self.carouselItems[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.carouselItems.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.frame.size.width-80;
    NSInteger index = (scrollView.contentOffset.x + width * 0.5) / width;
    //当滚动到最后一个Item时，继续滚向后动跳到第一个Item
    if (index == self.items.count + 1)
    {
        self.currentIndex = 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
        [self scrollToIndexPath:indexPath animated:NO];
        return;
    }
    //当滚动到第一个Item时，继续向前滚动跳到最后一个Item
    if (scrollView.contentOffset.x < width * 0.5)
    {
        self.currentIndex = self.items.count;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
        [self scrollToIndexPath:indexPath animated:NO];
        return;
    }

    
    //避免多次调用currentIndex的setter方法
    if (self.currentIndex != self.lastIndex)
    {
        self.currentIndex = index;
    }
    self.lastIndex = index;
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //关闭自动滚动
    [self.timer invalidate];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self setupTimer];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return self.frame.size;
    return CGSizeMake(CGRectGetWidth(self.frame)-80, CGRectGetHeight(self.frame));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了:%ld",indexPath.row);
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    if (_currentIndex < self.items.count + 1){
    
        NSInteger index = _currentIndex > 0 ? _currentIndex - 1 : 0;
        //设置标签
        return;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

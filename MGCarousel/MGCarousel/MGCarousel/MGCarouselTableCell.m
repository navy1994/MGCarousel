//
//  MGCarouselTableCell.m
//  MGCarousel
//
//  Created by haijun on 2018/5/21.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define ImageViewCount 3

#import "MGCarouselTableCell.h"

@interface MGCarouselTableCell()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, assign) NSInteger imageIndex;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation MGCarouselTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageIndex = 0;
        
        [self addSubview:self.scrollView];
        [self addSubview:self.titleLB];
        
        [self initImageView];

    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        _imageViewArray = [[NSMutableArray alloc] init];
    }
    return _imageViewArray;
}

- (UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.scrollView.frame)-30, CGRectGetWidth(self.scrollView.frame), 30)];
        _titleLB.textAlignment = NSTextAlignmentRight;
        _titleLB.textColor = [UIColor blackColor];
    }
    return _titleLB;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 150)];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(screenWidth*ImageViewCount, 0);
        _scrollView.contentOffset = CGPointMake(screenWidth, 0);
    }
    return _scrollView;
}

#pragma mark - event method
- (void)imageViewClick:(UITapGestureRecognizer *)sender{
    if (self.clickImageBlock) {
        [self updateImageIndex];
        self.clickImageBlock(self.imageIndex-1);
    }
}

#pragma mark - init
- (void)initImageView{
    for(NSInteger i = 0; i < ImageViewCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.scrollView addSubview:imageView];
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)]];
        [self.imageViewArray addObject:imageView];
    }
}

- (void)updateScrollViewContentSize{
    self.scrollView.contentSize = CGSizeMake(screenWidth*3, 0);
    self.scrollView.contentOffset = CGPointMake(screenWidth, 0);
}

#pragma mark - setter & getter
- (void)setImages:(NSMutableArray *)images{

    if (images.count > 0) {
        id firstObj = [images firstObject];
        id lastObj = [images lastObject];
        [images insertObject:lastObj atIndex:0];
        [images insertObject:firstObj atIndex:images.count];
    }
    if (!_images) {
        _images = [NSMutableArray array];
    }
    _images = images;
    self.imageIndex = 1;
    
    [self updateImageViewContent];
    [self updateScrollViewContentSize];

    [self beginTimer];

}

#pragma mark - 更新图片
- (void)updateImageViewContent{

    if (self.images.count > 2) {
        for (NSInteger i = 0; i < self.imageViewArray.count; i++) {
            UIImageView *imageView = [self.imageViewArray objectAtIndex:i];
            NSInteger imageIndex = 0;
            if (i == 0) {
                imageIndex = self.imageIndex - 1;
                if (imageIndex == -1) {
                    imageIndex = self.images.count - 2;
                }
            } else if (i == 1) {
                imageIndex = self.imageIndex;
            } else if (i == 2) {
                imageIndex = self.imageIndex + 1;
                if (imageIndex == self.images.count) {
                    imageIndex = 1;
                }
            }
            imageView.tag = imageIndex;
            
            //设置图片和标签
            imageView.image = [UIImage imageNamed:[self.images objectAtIndex:imageIndex]];
            self.titleLB.text = [NSString stringWithFormat:@"%ld/%ld",imageIndex-1,self.images.count-2];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //暂停定时器
    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //恢复定时器
    [self resumeWithTimeInterval:3.0f];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    UIImageView *middleImageView = nil;
    CGFloat minOffset = MAXFLOAT;
    
    for (UIImageView *imageView in self.imageViewArray) {
        CGFloat currentOffset = ABS(CGRectGetMinX(imageView.frame) - self.scrollView.contentOffset.x);
        if (currentOffset < minOffset){
            minOffset = currentOffset;
            middleImageView = imageView;
        }
        self.imageIndex = middleImageView.tag;
    }
}

//结束滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateImageIndex];
    [self updateImageViewContent];
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
}

- (void)setupImage:(NSMutableArray*)imageArr{
    self.images = imageArr;
}

- (void)updateImageIndex{
    if (self.imageIndex == 0) {
        self.imageIndex = self.images.count - 2;
    }else if(self.imageIndex == (self.images.count-1)){
        self.imageIndex = 1;
    }
}

#pragma mark -定时器-
- (void)beginTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)pauseTimer {
    if (!self.timer.isValid) return;
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)resumeTimer {
    if (!self.timer.isValid) return;
    [self.timer setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.timer.isValid) return;
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

- (void)timeAction{
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = CGPointMake(2 *CGRectGetWidth(self.scrollView.frame), 0);
    } completion:^(BOOL finished) {
        [self updateImageIndex];
        [self updateImageViewContent];
        [self updateScrollViewContentSize];
    }];
    
}

- (void)dealloc{
    [self stopTimer];
}
@end

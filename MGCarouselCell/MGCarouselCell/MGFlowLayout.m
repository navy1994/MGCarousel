//
//  MGFlowLayout.m
//  MGCarouselCell
//
//  Created by haijun on 2018/5/22.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#import "MGFlowLayout.h"

@implementation MGFlowLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 设置为水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //    // 设置内边距
    //    CGFloat insetGap = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    //    self.sectionInset = UIEdgeInsetsMake(0, insetGap, 0, insetGap);
    //
    
}

/**
 *  设置cell的显示大小
 *
 *  @param rect 范围
 *
 *  @return 返回所有元素的布局
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获取计算好的布局属性
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    // collectionView中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 对原有布局进行调整
    for (UICollectionViewLayoutAttributes *attributes in arr)
    {
        // cell的中点X 与 collectionView中心点的X间距
        CGFloat gapX = ABS(attributes.center.x - centerX);
        
        // 根据间距值计算 cell的缩放比例
        CGFloat scale = 1 - gapX / self.collectionView.frame.size.width * 0.3;
        
        // 设置缩放比例
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    
    return arr;
    
}

@end

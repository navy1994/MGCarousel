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
    
    // 设置内边距
    CGFloat insetGap = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, insetGap, 0, insetGap);
    
    
}

@end

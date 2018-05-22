//
//  MGCarouselView.h
//  MGCarouselCell
//
//  Created by haijun on 2018/5/21.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCarouselViewBlock)(NSInteger index);

@interface MGCarouselView : UIView
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) ClickCarouselViewBlock clickCellBlock;
@end

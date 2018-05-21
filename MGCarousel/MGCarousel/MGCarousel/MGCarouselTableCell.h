//
//  MGCarouselTableCell.h
//  MGCarousel
//
//  Created by haijun on 2018/5/21.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MGCarouselClickBlock)(NSInteger index);

@interface MGCarouselTableCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setupImage:(NSMutableArray*)imageArr;

@property (nonatomic, copy) MGCarouselClickBlock clickImageBlock;
@end

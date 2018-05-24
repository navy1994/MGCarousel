//
//  MGCarouselModel.h
//  MGCarouselCell
//
//  Created by haijun on 2018/5/21.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MGCarouselModel : NSObject
@property (nonatomic, copy) NSString *aUrl;
@property (nonatomic, copy) NSString *bUrl;
@property (nonatomic, copy) NSString *aCountryName;
@property (nonatomic, copy) NSString *bCountryName;
@property (nonatomic, assign) CGFloat aPlayNum;
@property (nonatomic, assign) CGFloat bPlayNum;
@end


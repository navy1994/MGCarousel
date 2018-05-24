//
//  MGCarouselCell.m
//  MGCarouselCell
//
//  Created by haijun on 2018/5/21.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#import "MGCarouselCell.h"
#import "MGCarouselModel.h"

@interface MGCarouselCell()
@property (nonatomic, strong) UIImageView *aCountryImageView;
@property (nonatomic, strong) UIImageView *bCountryImageView;
@property (nonatomic, strong) UILabel *aCountryLB;
@property (nonatomic, strong) UILabel *bCountryLB;

@property (nonatomic, strong) UIImageView *gameLogo;
@end

@implementation MGCarouselCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _aCountryImageView = [[UIImageView alloc]init];
        [self addSubview:_aCountryImageView];
        _bCountryImageView = [[UIImageView alloc]init];
        [self addSubview:_bCountryImageView];
        
        _aCountryLB = [[UILabel alloc]init];
        _aCountryLB.textColor = COLOR_WITH_HEX(0x333333);
        _aCountryLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_aCountryLB];
        _bCountryLB = [[UILabel alloc]init];
        _bCountryLB.textColor = COLOR_WITH_HEX(0x333333);
        _bCountryLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bCountryLB];
        
        _gameLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"vs.png"]];
        [self addSubview:_gameLogo];
        
        [self layoutUI];
    }
    return self;
}

- (void)setItemModel:(MGCarouselModel *)itemModel{
    _itemModel = itemModel;
    if (_itemModel) {
        
        _aCountryImageView.image = [UIImage imageNamed:[_itemModel.aCountryName stringByAppendingString:@".png"]];
        _bCountryImageView.image = [UIImage imageNamed:[_itemModel.bCountryName stringByAppendingString:@".png"]];
        
//        [_aCountryImageView sd_setImageWithURL:[NSURL URLWithString:_itemModel.aUrl]];
//        [_bCountryImageView sd_setImageWithURL:[NSURL URLWithString:_itemModel.bUrl]];
        
        _aCountryLB.text = _itemModel.aCountryName;
        _bCountryLB.text = _itemModel.bCountryName;
        
    }
}

- (void)layoutUI{
    
    [_gameLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.and.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.aCountryImageView.mas_centerY);
    }];
    
    [_aCountryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(40);
        make.right.equalTo(self.gameLogo.mas_left).offset(-25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80*303/486);
    }];
    
    [_bCountryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gameLogo.mas_right).offset(25);
        make.centerY.mas_equalTo(self.aCountryImageView.mas_centerY);
        make.width.mas_equalTo(self.aCountryImageView.mas_width);
        make.height.mas_equalTo(self.aCountryImageView.mas_height);
    }];
    
    [_aCountryLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aCountryImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(self.aCountryImageView.mas_width);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self.aCountryImageView.mas_centerX);
    }];
    
    [_bCountryLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.aCountryLB.mas_top);
        make.width.mas_equalTo(self.bCountryImageView.mas_width);
        make.height.mas_equalTo(self.aCountryLB.mas_height);
        make.centerX.mas_equalTo(self.bCountryImageView.mas_centerX);
    }];
    
}
@end

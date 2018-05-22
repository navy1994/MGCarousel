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
@property (nonatomic, strong) UILabel *aPlayTitleLB;
@property (nonatomic, strong) UILabel *bPlayTitleLB;
@property (nonatomic, strong) UILabel *aPlayNumLB;
@property (nonatomic, strong) UILabel *bPlayNumLB;
@property (nonatomic, strong) UIImageView *gameLogo;
@end

@implementation MGCarouselCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _aCountryImageView = [[UIImageView alloc]init];
        _aCountryImageView.backgroundColor = [UIColor redColor];
        [self addSubview:_aCountryImageView];
        _bCountryImageView = [[UIImageView alloc]init];
        _bCountryImageView.backgroundColor = [UIColor redColor];
        [self addSubview:_bCountryImageView];
        
        _aCountryLB = [[UILabel alloc]init];
        _aCountryLB.textColor = [UIColor blackColor];
        _aCountryLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_aCountryLB];
        _bCountryLB = [[UILabel alloc]init];
        _bCountryLB.textColor = [UIColor blackColor];
        _bCountryLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bCountryLB];
        
        _aPlayTitleLB = [[UILabel alloc]init];
        _aPlayTitleLB.textColor = [UIColor blackColor];
        _aPlayTitleLB.textAlignment = NSTextAlignmentCenter;
        _aPlayTitleLB.font = [UIFont systemFontOfSize:13];
        [self addSubview:_aPlayTitleLB];
        _bPlayTitleLB = [[UILabel alloc]init];
        _bPlayTitleLB.textColor = [UIColor blackColor];
        _bPlayTitleLB.textAlignment = NSTextAlignmentCenter;
        _bPlayTitleLB.font = [UIFont systemFontOfSize:13];
        [self addSubview:_bPlayTitleLB];
        
        _aPlayNumLB = [[UILabel alloc]init];
        _aPlayNumLB.textColor = [UIColor blackColor];
        _aPlayNumLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_aPlayNumLB];
        _bPlayNumLB = [[UILabel alloc]init];
        _bPlayNumLB.textColor = [UIColor blackColor];
        _bPlayNumLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bPlayNumLB];
        
        _gameLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"vs.png"]];
        [self addSubview:_gameLogo];
        
        _aPlayTitleLB.text = @"累计播放次数";
        _bPlayTitleLB.text = @"累计播放次数";
        
        [self layoutUI];
    }
    return self;
}

- (void)setItemModel:(MGCarouselModel *)itemModel{
    _itemModel = itemModel;
    if (_itemModel) {
        _aCountryLB.text = _itemModel.aCountryName;
        _bCountryLB.text = _itemModel.bCountryName;
        _aPlayNumLB.text = [NSString stringWithFormat:@"%@万",_itemModel.aPlayNum];
        _bPlayNumLB.text = [NSString stringWithFormat:@"%@万",_itemModel.bPlayNum];
    }
}

- (void)layoutUI{
    
    [_gameLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.and.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.aCountryImageView.mas_centerY);
    }];
    
    [_aCountryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(30);
        make.right.equalTo(self.gameLogo.mas_left).offset(-30);
        make.width.and.height.mas_equalTo(70);
    }];
    
    [_bCountryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gameLogo.mas_right).offset(30);
        make.centerY.mas_equalTo(self.aCountryImageView.mas_centerY);
        make.width.and.height.mas_equalTo(self.aCountryImageView);
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
    
    [_aPlayTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.aPlayNumLB.mas_top).offset(-5);
        make.height.and.width.mas_equalTo(self.aPlayNumLB);
        make.centerX.mas_equalTo(self.aPlayNumLB.mas_centerX);
    }];

    [_bPlayTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bPlayNumLB.mas_top).offset(-5);
        make.height.and.width.mas_equalTo(self.bPlayNumLB);
        make.centerX.mas_equalTo(self.bPlayNumLB.mas_centerX);
    }];
    
    [_aPlayNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.centerX.mas_equalTo(self.aCountryImageView.mas_centerX);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [_bPlayNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.centerX.mas_equalTo(self.bCountryImageView.mas_centerX);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    
}
@end

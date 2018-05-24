//
//  MGCarouselBottomView.m
//  MGCarouselCell
//
//  Created by haijun on 2018/5/24.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#import "MGCarouselBottomView.h"
#import "MGCarouselModel.h"

@interface MGCarouselBottomView()
@property (nonatomic, strong) UILabel *aPlayTitleLB;
@property (nonatomic, strong) UILabel *bPlayTitleLB;
@property (nonatomic, strong) UILabel *aPlayNumLB;
@property (nonatomic, strong) UILabel *bPlayNumLB;
@end

@implementation MGCarouselBottomView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _aPlayTitleLB = [[UILabel alloc]init];
        _aPlayTitleLB.textColor = COLOR_WITH_HEX(0x333333);
        _aPlayTitleLB.textAlignment = NSTextAlignmentCenter;
        _aPlayTitleLB.font = [UIFont boldSystemFontOfSize:13];
        [self addSubview:_aPlayTitleLB];
        _bPlayTitleLB = [[UILabel alloc]init];
        _bPlayTitleLB.textColor = COLOR_WITH_HEX(0x333333);
        _bPlayTitleLB.textAlignment = NSTextAlignmentCenter;
        _bPlayTitleLB.font = [UIFont boldSystemFontOfSize:13];
        [self addSubview:_bPlayTitleLB];
        
        _aPlayNumLB = [[UILabel alloc]init];
        _aPlayNumLB.textColor = COLOR_WITH_HEX(0x333333);;
        _aPlayNumLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_aPlayNumLB];
        _bPlayNumLB = [[UILabel alloc]init];
        _bPlayNumLB.textColor = COLOR_WITH_HEX(0x333333);;
        _bPlayNumLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bPlayNumLB];
        
        _aPlayTitleLB.text = @"累计播放次数";
        _bPlayTitleLB.text = @"累计播放次数";
        
        [self layoutUI];

    }
    return self;
}

- (void)setModel:(MGCarouselModel *)model{
    _model = model;
    if (_model) {
        
        _aPlayNumLB.attributedText = [self stringToAttributedString:[self changeNumberFormat2:_model.aPlayNum]];
        _bPlayNumLB.attributedText = [self stringToAttributedString:[self changeNumberFormat2:_model.bPlayNum]];
    }
}

- (NSMutableAttributedString*)stringToAttributedString:(NSString*)str{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:COLOR_WITH_HEX(0xFB7A52), NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"万" attributes:@{NSForegroundColorAttributeName:COLOR_WITH_HEX(0x333333), NSFontAttributeName:[UIFont systemFontOfSize:15]}]];
    return attStr;
}

-(NSString *)changeNumberFormat2:(CGFloat)num
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.0;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:num]];
    return formattedNumberString;
}

- (void)layoutUI{
    
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
        make.centerX.equalTo(self.mas_centerX).offset(-80);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [_bPlayNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.centerX.equalTo(self.mas_centerX).offset(80);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

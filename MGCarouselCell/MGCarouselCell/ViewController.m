//
//  ViewController.m
//  MGCarouselCell
//
//  Created by haijun on 2018/5/21.
//  Copyright © 2018年 wondertex. All rights reserved.
//

#import "ViewController.h"
#import "MGCarouselView.h"
#import "MGCarouselModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor blackColor];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    MGCarouselView *carouselView = [[MGCarouselView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
//    carouselView.selectItemComplete(<#NSInteger index#>) = ^(NSInteger index) {
//        NSLog(@"点击了:%ld",index);
//    };
    [carouselView setSelectItemComplete:^(NSInteger index) {
         NSLog(@"选中了:%ld",index);
    }];
    carouselView.items = [MGCarouselModel mj_objectArrayWithKeyValuesArray:dic[@"Items"]];
    
    [self.view addSubview:carouselView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

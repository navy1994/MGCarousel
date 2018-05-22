# MGCarousel

<div align=center><img width="300" height="605" src="https://github.com/navy1994/MGCarousel/blob/master/gif/demo.gif"/></div>

1.代码示例

	MGCarouselView *carouselView = [[MGCarouselView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
	carouselView.clickCellBlock = ^(NSInteger index) {
	NSLog(@"点击了:%ld",index);
	};
	carouselView.items = [MGCarouselModel mj_objectArrayWithKeyValuesArray:dic[@"Items"]];
	[self.view addSubview:carouselView];

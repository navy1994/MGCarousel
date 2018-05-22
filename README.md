# MGCarousel


1.代码示例

	MGCarouselView *carouselView = [[MGCarouselView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
	carouselView.clickCellBlock = ^(NSInteger index) {
	NSLog(@"点击了:%ld",index);
	};
	carouselView.items = [MGCarouselModel mj_objectArrayWithKeyValuesArray:dic[@"Items"]];
	[self.view addSubview:carouselView];

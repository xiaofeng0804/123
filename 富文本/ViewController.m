//
//  ViewController.m
//  富文本
//
//  Created by 叶兵锋 on 2018/5/7.
//  Copyright © 2018年 yebingfeng. All rights reserved.
//

#import "ViewController.h"
#import "YBFLabel.h"


#define Lab_W self.view.bounds.size.width-30.f
#define FONT(X) [UIFont systemFontOfSize:X]
#define BFONT(X) [UIFont boldSystemFontOfSize:X]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSArray *textsArray = @[@"你呀别总想搞个大新闻!",
                            @"图样图森破!",
                            @"什么大风大浪我没见过",
                            @"我和华莱士谈笑风生"];
    
    NSArray *colorsArray = @[[UIColor orangeColor],
                             [UIColor redColor],
                             [UIColor blueColor],
                             [UIColor greenColor]];
    
    NSArray *fontsArray = @[FONT(20), BFONT(35), FONT(25), BFONT(30)];
    
    YBFLabel *lab = [[YBFLabel alloc] initWithFrame:CGRectMake(15.f, 80.f, Lab_W, 10)];
    lab.numberOfLines = 0;
    // 生成富文本字符串
    NSAttributedString *attributeStr = [YBFLabel attributedTextArray:textsArray
                                                         textColors:colorsArray
                                                          textfonts:fontsArray
                                                        lineSpacing:20.f];
    lab.attributedText = attributeStr;
    // 计算富文本的高度
    CGFloat lab_h = [YBFLabel sizeLabelWidth:Lab_W
                             attributedText:attributeStr].height;
    lab.frame = CGRectMake(15.f, 80.f, Lab_W, lab_h);
    
    [self.view addSubview:lab];
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

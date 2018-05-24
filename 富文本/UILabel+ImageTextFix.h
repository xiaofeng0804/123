//
//  UILabel+ImageTextFix.h
//  富文本
//
//  Created by 叶兵锋 on 2018/5/8.
//  Copyright © 2018年 yebingfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ImageTextFix)
// 由多个attributedString拼接成新的attributedString，item意为由text或image生成的单个attributedString
+ (NSAttributedString *)fixAttributeStrWithItems:(NSArray *)items;


//
+ (NSAttributedString *)fixAttributedStrWithTexts:(NSArray *)texts
                                       textColors:(NSArray *)colors
                                        textfonts:(NSArray *)fonts
                                            image:(UIImage *)image
                                      insertIndex:(NSInteger)index
                                      lineSpacing:(CGFloat)l_spacing;



+ (NSAttributedString *)fixAttributedStrWithTexts:(NSArray *)texts
                                       textColors:(NSArray *)colors
                                        textfonts:(NSArray *)fonts
                                            image:(UIImage *)image
                                      insertIndex:(NSInteger)index
                                      imageBounds:(CGRect)bounds
                                      lineSpacing:(CGFloat)l_spacing;


// 由text生成attributedString
+ (NSAttributedString *)attributedStrWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font;


// 由image生成attributedString
+ (NSAttributedString *)attributedStrWithImage:(UIImage *)image imageBounds:(CGRect)bounds;


@end

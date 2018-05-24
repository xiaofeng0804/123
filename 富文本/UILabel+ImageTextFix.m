//
//  UILabel+ImageTextFix.m
//  富文本
//
//  Created by 叶兵锋 on 2018/5/8.
//  Copyright © 2018年 yebingfeng. All rights reserved.
//

#import "UILabel+ImageTextFix.h"

@implementation UILabel (ImageTextFix)
// 由多个attributedString拼接成新的attributedString，item意为由text或image生成的单个attributedString
+ (NSAttributedString *)fixAttributeStrWithItems:(NSArray *)items
{
    NSMutableAttributedString *resultMAttrStr = [[NSMutableAttributedString alloc] init];
    for(int i=0; i<items.count; i++)
    {
        if([items[i] isKindOfClass:[NSAttributedString class]]){
            [resultMAttrStr appendAttributedString:items[i]];
        }
    }
    return resultMAttrStr;
}



// 图文混合，只有一张图片
+ (NSAttributedString *)fixAttributedStrWithTexts:(NSArray *)texts
                                       textColors:(NSArray *)colors
                                        textfonts:(NSArray *)fonts
                                            image:(UIImage *)image
                                      insertIndex:(NSInteger)index
                                      lineSpacing:(CGFloat)l_spacing
{
    return [[self class] fixAttributedStrWithTexts:texts
                                        textColors:colors
                                         textfonts:fonts
                                             image:image
                                       insertIndex:index
                                       imageBounds:CGRectZero
                                       lineSpacing:l_spacing];
}


// 同上，多了一个l_spacing参数
+ (NSAttributedString *)fixAttributedStrWithTexts:(NSArray *)texts
                                       textColors:(NSArray *)colors
                                        textfonts:(NSArray *)fonts
                                            image:(UIImage *)image
                                      insertIndex:(NSInteger)index
                                      imageBounds:(CGRect)bounds
                                      lineSpacing:(CGFloat)l_spacing

{
    if(texts.count==0){
        return nil;
    }
    
    NSMutableAttributedString *resultAttrStr = [[NSMutableAttributedString alloc] init];
    NSInteger locationIndex = 0;
    for(int i=0; i<texts.count; i++)
    {
        NSString *text = texts[i];
        NSAttributedString *tempMAttrStr = [[self class] attributedStrWithText:texts[i] textColor:colors[i] textFont:fonts[i]];
        [resultAttrStr appendAttributedString:tempMAttrStr];
        
        // 计算图片应该插入的位置
        if(index<=texts.count){
            
            if(index == 0){
                
                locationIndex = 0;
                
            }
            else{
                if(i<index){
                    locationIndex+=text.length;
                }
            }
        }
        
    }
    if(l_spacing>0){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = l_spacing;
        [resultAttrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, resultAttrStr.length)];
    }
    
    // 插入图片附件（插入图片要在最后，不然会有影响）
    NSMutableAttributedString *resultAttrStr1 = [[self class] insertMAttrStr:resultAttrStr image:image imageBounds:bounds insertIndex:locationIndex];
    
    
    return resultAttrStr1;
}



+ (NSMutableAttributedString *)insertMAttrStr:(NSMutableAttributedString *)mAttrStr image:(UIImage *)image imageBounds:(CGRect)bounds insertIndex:(NSInteger)index
{
    if(image){
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        attachment.bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
        NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [mAttrStr insertAttributedString:attachmentAttrStr atIndex:index];
    }
    
    return [mAttrStr copy];
}




// 由text生成attributedString
+ (NSAttributedString *)attributedStrWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font
{
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [mAttrStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length)];
    [mAttrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    
    return mAttrStr;
}

// 由image生成attributedString
+ (NSAttributedString *)attributedStrWithImage:(UIImage *)image imageBounds:(CGRect)bounds
{
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    return attachmentAttrStr;
}


@end

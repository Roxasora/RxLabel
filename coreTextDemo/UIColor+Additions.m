//
//  UIColor+Additions.m
//  coreTextDemo
//
//  Created by roxasora on 15/10/8.
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor(Additions)

+(UIColor*)colorWithHexStr:(NSString *)HexColorStr{
    if (![HexColorStr hasPrefix:@"0X"]) {
        HexColorStr = [NSString stringWithFormat:@"0X%@",HexColorStr];
    }
    if (HexColorStr.length != 8) {
        return [UIColor redColor];
    }
    unsigned long hexColorLongValue = strtoul([HexColorStr UTF8String], 0, 16);
    UIColor* color = [UIColor colorWithRed:((float)((hexColorLongValue & 0xFF0000) >> 16))/255.0 green:((float)((hexColorLongValue & 0xFF00) >> 8))/255.0 blue:((float)(hexColorLongValue & 0xFF))/255.0 alpha:1.0];
    if (!color) {
        return [UIColor redColor];
    }else{
        return color;
    }
}

@end

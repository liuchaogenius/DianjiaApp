//
//  CALayer+CCAddition.m
//  YHB_Prj
//
//  Created by yato_kami on 15/8/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "CALayer+CCAddition.h"

@implementation CALayer (CCAddition)

- (UIColor *)borderColorFromUIColor {
    
    return [UIColor colorWithCGColor:self.borderColor];
    
}

-(void)setBorderColorFromUIColor:(UIColor *)color
{

    self.borderColor = color.CGColor;
    
}

@end

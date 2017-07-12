//
//  UIScrollView+Touch.m
//  TestScroll
//
//  Created by Zhuge_Su on 2017/7/12.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "UIScrollView+Touch.h"

@implementation UIScrollView (Touch)

/* 重写 touchesBegan */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self isMemberOfClass:[UIScrollView class]]) {
        
    } else {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesBegan:touches withEvent:event];
        }
    }
}

/* 重写 touchesMoved */
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self isMemberOfClass:[UIScrollView class]]) {
        
    } else {
        [[self nextResponder] touchesMoved:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesMoved:touches withEvent:event];
        }
    }
}

/* 重写 touchesEnded */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self isMemberOfClass:[UIScrollView class]]) {
    
    } else {
        [[self nextResponder] touchesEnded:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesEnded:touches withEvent:event];
        }
    }
}


@end

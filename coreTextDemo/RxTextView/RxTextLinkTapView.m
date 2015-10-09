//
//  RxTextLinkTapView.m
//  coreTextDemo
//
//  Created by roxasora on 15/10/9.
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import "RxTextLinkTapView.h"

@interface RxTextLinkTapView ()


@end
@implementation RxTextLinkTapView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 2;
        self.highlighted = NO;
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer* tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame urlStr:(NSString *)urlStr font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing{
    
    frame.origin.x -= 3;
    
    frame.origin.y += (font.pointSize/16 * 3);
    frame.size.height += 3;
    
    frame.size.width += 6;
    
    self = [self initWithFrame:frame];
    self.urlStr = urlStr;
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
    [self setHighlighted:YES];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self setHighlighted:NO];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self setHighlighted:NO];
}

-(void)setHighlighted:(BOOL)highlighted{
    _highlighted = highlighted;
//    NSLog(@"cao nim ");
    if (highlighted) {
        self.backgroundColor = self.tapColor;
        if ([self.delegate respondsToSelector:@selector(RxTextLinkTapView:didBeginHighlightedWithUrlStr:)]) {
            [self.delegate RxTextLinkTapView:self didBeginHighlightedWithUrlStr:self.urlStr];
        }
    }else{
        self.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(RxTextLinkTapView:didEndHighlightedWithUrlStr:)]) {
            [self.delegate RxTextLinkTapView:self didEndHighlightedWithUrlStr:self.urlStr];
        }
    }
}

-(void)handleTap:(UITapGestureRecognizer*)sender{
    [self setHighlighted:YES];
    [self performSelector:@selector(backToNormal) withObject:nil afterDelay:0.25];
    if ([self.delegate respondsToSelector:@selector(RxTextLinkTapView:didDetectTapWithUrlStr:)]) {
        [self.delegate RxTextLinkTapView:self didDetectTapWithUrlStr:self.urlStr];
    }
}

-(void)backToNormal{
    [self setHighlighted:NO];
}
@end

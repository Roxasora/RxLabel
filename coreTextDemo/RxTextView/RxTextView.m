//
//  RxTextView.m
//  coreTextDemo
//
//  Created by roxasora on 15/10/8.
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import "RxTextView.h"
#import <CoreText/CoreText.h>
#import "RxTextLinkTapView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RxUrlRegular @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
#define RxTopicRegular @"#[^#]+#"

#define rxHighlightTextTypeUrl @"url"

#define subviewsTag_linkTapViews -333

@interface RxTextView ()<RxTextLinkTapViewDelegate>

@end

@implementation RxTextView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _font = [UIFont systemFontOfSize:16];
        _textColor = UIColorFromRGB(0X333333);
        _linkColor = UIColorFromRGB(0X2081ef);
        _linkTapViewColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
        _lineSpacing = 0;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setText:(NSString *)text{
    _text = text;
//    [self drawRect:self.bounds];
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font{
    _font = font;
    [self setNeedsDisplay];
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self setNeedsDisplay];
}

-(void)setLinkColor:(UIColor *)linkColor{
    _linkColor = linkColor;
    [self setNeedsDisplay];
}

-(void)setLineSpacing:(NSInteger)lineSpacing{
    _lineSpacing = lineSpacing;
    [self setNeedsDisplay];
}

-(void)setLinkTapViewColor:(UIColor *)linkTapViewColor{
    _linkTapViewColor = linkTapViewColor;
    for (UIView* subview in self.subviews) {
        if (subview.tag == NSIntegerMin) {
            RxTextLinkTapView* tapView = (RxTextLinkTapView*)tapView;
            tapView.tapColor = linkTapViewColor;
        }
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, self.bounds);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    //set line height font color and break mode
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)self.font.fontName, self.font.pointSize, NULL);
    CGFloat minLineHeight = self.font.pointSize+3,
    maxLineHeight = minLineHeight,
    lineSpacing = self.lineSpacing;
    
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    CTTextAlignment alignment = kCTLeftTextAlignment;
    
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[6]){
        {kCTParagraphStyleSpecifierAlignment,sizeof(alignment),&alignment},
        {kCTParagraphStyleSpecifierMinimumLineHeight,sizeof(minLineHeight),&minLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(maxLineHeight),&maxLineHeight},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(lineSpacing),&lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(lineSpacing),&lineSpacing},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(lineBreakMode),&lineBreakMode}
    }, 6);
    
    
    NSDictionary* initAttrbutes = @{
                                    (NSString*)kCTFontAttributeName: (__bridge id)fontRef,
                                    (NSString*)kCTForegroundColorAttributeName:(id)self.textColor.CGColor,
                                    (NSString*)kCTParagraphStyleAttributeName:(id)style
                                    };
   
    //先从self text 中过滤掉 url ，将其保存在array中
    /**
     @[
        @{
            @"range":@(m,n),
            @"urlStr":@"http://dsadd"
        }
     ]
     */
//    NSMutableArray* urlArray = [NSMutableArray array];
//    [self filtUrlWithUrlArray:urlArray];
//    
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:self.text
                                                                                attributes:initAttrbutes];
    
    //检测url
    NSArray* urlMatches = [[NSRegularExpression regularExpressionWithPattern:RxUrlRegular
                                                                     options:NSRegularExpressionDotMatchesLineSeparators error:nil]
                           matchesInString:self.text
                           options:0
                           range:NSMakeRange(0, self.text.length)];
    
    for (NSTextCheckingResult* match in urlMatches) {
        NSString* urlStr = [self.text substringWithRange:match.range];
        
        [attrStr addAttributes:@{
                                 @"url":urlStr,
                                 NSBackgroundColorAttributeName:(id)[UIColor redColor],
                                 (NSString*)kCTForegroundColorAttributeName:(id)self.linkColor.CGColor
                                 }
                         range:match.range];
    }
    
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attrStr.length), path, NULL);
    
    //create link tap views
    for (UIView* subview in self.subviews) {
        if (subview.tag == NSIntegerMin) {
            [subview removeFromSuperview];
        }
    }
    
    //get lines in frame
    NSArray* lines = (NSArray*)CTFrameGetLines(frame);
    CFIndex lineCount = [lines count];
    
    //get origin point of each line
    CGPoint origins[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    for (CFIndex index = 0; index < lineCount; index++) {
        //get line ref of line
        CTLineRef line = CFArrayGetValueAtIndex((CFArrayRef)lines, index);
        
        //get run
        CFArrayRef glyphRuns = CTLineGetGlyphRuns(line);
        CFIndex glyphCount = CFArrayGetCount(glyphRuns);
        for (int i = 0; i < glyphCount; i++) {
            CTRunRef run = CFArrayGetValueAtIndex(glyphRuns, i);
            
            NSDictionary* attrbutes = (NSDictionary*)CTRunGetAttributes(run);
//            NSLog(@"%@",attrbutes);
            
            if ([attrbutes objectForKey:@"url"]) {
                CGRect runBounds;
                
                CGFloat ascent;
                CGFloat descent;
                runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
                runBounds.size.height = ascent + descent;
                
                runBounds.origin.x = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
                runBounds.origin.y = self.frame.size.height - origins[index].y - runBounds.size.height;
                
#ifdef RXDEBUG
                UIView* randomView = [[UIView alloc] initWithFrame:runBounds];
                randomView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.2];
                [self addSubview:randomView];
#endif
                
                //create hover frame
                RxTextLinkTapView* hoverView = [[RxTextLinkTapView alloc] initWithFrame:runBounds
                                                                                 urlStr:attrbutes[@"url"]
                                                                                   font:self.font
                                                                            lineSpacing:self.lineSpacing];
                hoverView.tapColor = self.linkTapViewColor;
                hoverView.tag = NSIntegerMin;
                hoverView.delegate = self;
                [self addSubview:hoverView];
            }
        }
    }
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(frameSetter);
    CFRelease(path);
}


-(void)filtUrlWithUrlArray:(NSMutableArray*)urlArray{
    NSArray* urlMatches = [[NSRegularExpression regularExpressionWithPattern:RxUrlRegular
                                                                     options:NSRegularExpressionDotMatchesLineSeparators error:nil]
                           matchesInString:self.text
                           options:0
                           range:NSMakeRange(0, self.text.length)];

    //range 的偏移量，每次replace之后，下次循环中，要加上这个偏移量
    NSInteger rangeOffset = 0;
    for (NSTextCheckingResult* match in urlMatches) {
        NSString* urlStr = [self.text substringWithRange:match.range];
        
        NSRange range = match.range;
        range.location += rangeOffset;
        rangeOffset -= (range.length - 1);
       
        unichar objectReplacementChar = 0xFFFC;
        NSString * replaceContent = [NSString stringWithCharacters:&objectReplacementChar length:1];
        self.text = [self.text stringByReplacingCharactersInRange:range withString:replaceContent];
        
        range.length = 1;
        [urlArray addObject:@{
                              @"range":[NSValue valueWithRange:range],
                              @"urlStr":urlStr
                              }];
//        [attrStr addAttributes:@{
//                                 @"url":urlStr,
//                                 NSBackgroundColorAttributeName:(id)[UIColor redColor],
//                                 (NSString*)kCTForegroundColorAttributeName:(id)self.linkColor.CGColor
//                                 }
//                         range:match.range];
    }
}





+(CGFloat)heightForText:(NSString *)text width:(CGFloat)width font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing{
    CGFloat height = 0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, width, 9999));
    
    //set line height font color and break mode
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    
    CGFloat minLineHeight = font.pointSize+3,
    maxLineHeight = minLineHeight;
    
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    CTTextAlignment alignment = kCTLeftTextAlignment;
    
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[6]){
        {kCTParagraphStyleSpecifierAlignment,sizeof(alignment),&alignment},
                {kCTParagraphStyleSpecifierMinimumLineHeight,sizeof(minLineHeight),&minLineHeight},
                {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(maxLineHeight),&maxLineHeight},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(lineSpacing),&lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(lineSpacing),&lineSpacing},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(lineBreakMode),&lineBreakMode}
    }, 6);
    
    
    NSDictionary* initAttrbutes = @{
                                    (NSString*)kCTFontAttributeName: (__bridge id)fontRef,
                                    (NSString*)kCTParagraphStyleAttributeName:(id)style
                                    };
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:text
                                                                                attributes:initAttrbutes];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attrStr.length), path, NULL);
    
    //get lines in frame
    NSArray* lines = (NSArray*)CTFrameGetLines(frame);
    CFIndex lineCount = [lines count];
    
    //get origin point of each line
    CGPoint origins[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    CGFloat colHeight = 9999;
    
    height = 9999 - origins[lines.count - 1].y;
    
    //加上偏移补全量
    height += 6;
    height = ceilf(height);
    
//    for (CFIndex index = 0; index < lineCount; index++) {
//        //get line ref of line
//        CTLineRef line = CFArrayGetValueAtIndex((CFArrayRef)lines, index);
//
//        //get run
//        CFArrayRef glyphRuns = CTLineGetGlyphRuns(line);
//        CFIndex glyphCount = CFArrayGetCount(glyphRuns);
//        
//        CTRunRef run = CFArrayGetValueAtIndex(glyphRuns, 0);
//        
//        CGRect runBounds;
//        
//        CGFloat ascent;
//        CGFloat descent;
//        runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
//        runBounds.size.height = ascent + descent;
//        
//        height += runBounds.size.height;
//        NSLog(@"now run %@",NSStringFromCGRect(runBounds));
//        
//        runBounds.origin.x = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
//        runBounds.origin.y = 9999 - origins[index].y - runBounds.size.height;
//    }
    CFRelease(frame);
    CFRelease(frameSetter);
    
    return height;
}

#pragma mark - RxTextLinkTapView delegate
-(void)RxTextLinkTapView:(RxTextLinkTapView *)linkTapView didDetectTapWithUrlStr:(NSString *)urlStr{
//    NSLog(@"link tapped !! %@",urlStr);
    if ([self.delegate respondsToSelector:@selector(RxTextView:didDetectedTapLinkWithUrlStr:)]) {
        [self.delegate RxTextView:self didDetectedTapLinkWithUrlStr:urlStr];
    }
}

-(void)RxTextLinkTapView:(RxTextLinkTapView *)linkTapView didBeginHighlightedWithUrlStr:(NSString *)urlStr{
    [self setOtherLinkTapViewHightlighted:YES withUrlStr:urlStr];
}

-(void)RxTextLinkTapView:(RxTextLinkTapView *)linkTapView didEndHighlightedWithUrlStr:(NSString *)urlStr{
    [self setOtherLinkTapViewHightlighted:NO withUrlStr:urlStr];
}

-(void)setOtherLinkTapViewHightlighted:(BOOL)hightlighted withUrlStr:(NSString*)urlStr{
    for (UIView* subview in self.subviews) {
        if (subview.tag == NSIntegerMin) {
            RxTextLinkTapView* lineTapView = (RxTextLinkTapView*)subview;
            if ([lineTapView.urlStr isEqualToString:urlStr] && lineTapView.highlighted != hightlighted) {
                [lineTapView setHighlighted:hightlighted];
            }
        }
    }
}

@end

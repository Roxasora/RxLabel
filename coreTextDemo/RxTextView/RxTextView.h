//
//  RxTextView.h
//  coreTextDemo
//
//  Created by roxasora on 15/10/8.
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RxTextViewDelegate;

@interface RxTextView : UIView

@property id<RxTextViewDelegate> delegate;


/**
 *  text
 */
@property (nonatomic,strong)NSString* text;

/**
 *  textColor default is #333333
 */
@property (nonatomic,strong)UIColor* textColor;

/**
 *  font default is 16
 */
@property (nonatomic,strong)UIFont* font;

/**
 *  linespacing default is 0
 */
@property (nonatomic)NSInteger linespacing;

/**
 *  color of link button,default is custom blue
 */
@property (nonatomic)UIColor* linkButtonColor;

/**
 *  custom the color array of your own urls, like orange taobao, red tmall, and green douban
 @[
     @{
        @"scheme":@"taobao",
        @"title":@"淘宝",
        @"color":@0Xff0000
     }
 ]
 */
@property (nonatomic)NSMutableArray* urlCustomArray;

/**
 *  get height with text width font and spacing
 *
 *  @param text text
 *  @param width width
 *  @param font font
 *  @param linespacing spacing
 *
 *  @return float height
 */
+(CGFloat)heightForText:(NSString*)text width:(CGFloat)width font:(UIFont*)font linespacing:(CGFloat)linespacing;
+(void)filtUrlWithOriginText:(NSString*)originText urlArray:(NSMutableArray*)urlArray filteredText:(NSString**)filterText;

@end

@protocol RxTextViewDelegate <NSObject>

-(void)RxTextView:(RxTextView*)textView didDetectedTapLinkWithUrlStr:(NSString*)urlStr;

@end

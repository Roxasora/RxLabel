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
@property (nonatomic)NSInteger lineSpacing;

/**
 *  color of link,default is custom blue
 */
@property (nonatomic)UIColor* linkColor;

/**
 *  color of hover view when link tapped default is lightgray with alpha 0.2
 */
@property (nonatomic)UIColor* linkTapViewColor;

/**
 *  get height with text width font and spacing
 *
 *  @param text text
 *  @param width width
 *  @param font font
 *  @param lineSpacing spacing
 *
 *  @return float height
 */
+(CGFloat)heightForText:(NSString*)text width:(CGFloat)width font:(UIFont*)font lineSpacing:(CGFloat)lineSpacing;

@end

@protocol RxTextViewDelegate <NSObject>

-(void)RxTextView:(RxTextView*)textView didDetectedTapLinkWithUrlStr:(NSString*)urlStr;

@end

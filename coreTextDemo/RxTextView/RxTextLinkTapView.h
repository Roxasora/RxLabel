//
//  RxTextLinkTapView.h
//  coreTextDemo
//
//  Created by roxasora on 15/10/9.
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RxTextLinkTapViewDelegate;

@interface RxTextLinkTapView : UIView

/**
 *  create instance with frame and url
 *
 *  @param frame  frame
 *  @param urlStr nsstring url
 *
 *  @return instance
 */
-(id)initWithFrame:(CGRect)frame urlStr:(NSString*)urlStr font:(UIFont*)font lineSpacing:(CGFloat)lineSpacing;

/**
 *  delegate
 */
@property id<RxTextLinkTapViewDelegate> delegate;

/**
 *  nsstring url
 */
@property (nonatomic)NSString* urlStr;

/**
 *  hightlighted just like uibutton
 */
@property (nonatomic)BOOL highlighted;

/**
 *  color when tapped
 */
@property (nonatomic)UIColor* tapColor;
@end

@protocol RxTextLinkTapViewDelegate <NSObject>

-(void)RxTextLinkTapView:(RxTextLinkTapView*)linkTapView didDetectTapWithUrlStr:(NSString*)urlStr;
-(void)RxTextLinkTapView:(RxTextLinkTapView*)linkTapView didBeginHighlightedWithUrlStr:(NSString*)urlStr;
-(void)RxTextLinkTapView:(RxTextLinkTapView*)linkTapView didEndHighlightedWithUrlStr:(NSString*)urlStr;

@end

//
//  ViewController.m
//  coreTextDemo
//
//  Created by roxasora on 15/10/8.
//  https://github.com/Roxasora/RxTextView
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import "ViewController.h"
#import "RxTextView.h"
#import "UIScreen+Additions.h"

@interface ViewController ()<RxTextViewDelegate>

- (IBAction)alignSegmentValueChanged:(id)sender;
- (IBAction)fontSizeSliderValueChanged:(id)sender;
- (IBAction)lineSpacingSliderValueChanged:(id)sender;
- (IBAction)linkButtonColorBtnClicked:(id)sender;
- (IBAction)textColorBtnClicked:(id)sender;

@end

@implementation ViewController{
    RxTextView* textView;
}

//static NSString* fuckStr = @"http://fuckyourSelf.com 下面我们来尝试完成一个基于 CoreText 的排版引擎。我们将从最简单的排版功能开始，然后逐步支持图文混排，链接点击等功能。http://baidu.com 我乐呵七大时间啊就是控件";
static NSString* textStr = @"http://weibo.com/1694819202 hello Indian MI fans~~~\nExcept normal urls\nthis is a taobao url http://taobao.com this is a Github url https://github.com/Roxasora/RxTextView";
#define fontSize 17
#define lineSpacing 5
#define textViewWidth SCREEN_WIDTH - 40
#define margin 20

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height = [RxTextView heightForText:textStr width:textViewWidth font:[UIFont systemFontOfSize:fontSize] linespacing:lineSpacing];
    
    textView = [[RxTextView alloc] initWithFrame:CGRectMake(margin, margin*1.5, textViewWidth, height)];
    
    textView.textColor = [UIColor grayColor];
    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.linespacing = lineSpacing;
    textView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    textView.delegate = self;
    
    textView.text = textStr;
    
    //if you want to custom the different color and title for particular urls, do like this
    textView.customUrlArray = [@[
                                @{
                                    @"scheme":@"taobao",
                                    @"title":@"淘宝",
                                    @"color":@0XF97840
                                    },
                                @{
                                    @"scheme":@"github",
                                    @"title":@"Github",
                                    @"color":@0X333333
                                    }
                                ] mutableCopy];
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma textview delegate
-(void)RxTextView:(RxTextView *)textView didDetectedTapLinkWithUrlStr:(NSString *)urlStr{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"url tapped" message:urlStr delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - tools action
- (IBAction)alignSegmentValueChanged:(id)sender {
    UISegmentedControl* seg = (UISegmentedControl*)sender;
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            textView.textAlignment = NSTextAlignmentLeft;
        }
            break;
        case 1:
        {
            textView.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 2:
        {
            textView.textAlignment = NSTextAlignmentRight;
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)fontSizeSliderValueChanged:(id)sender {
    UISlider* slider = (UISlider*)sender;
    CGFloat value = slider.value;
    
    CGFloat fontSizeIncrement = ceilf((value - 0.5)*6);
    
    textView.font = [UIFont systemFontOfSize:(16 + fontSizeIncrement)];
    [textView sizeToFit];
}

- (IBAction)lineSpacingSliderValueChanged:(id)sender {
    UISlider* slider = (UISlider*)sender;
    CGFloat value = slider.value;
    
    textView.linespacing = lineSpacing + value*10;
    [textView sizeToFit];
}

- (IBAction)linkButtonColorBtnClicked:(id)sender {
    textView.linkButtonColor = [self randomColor];
}

- (IBAction)textColorBtnClicked:(id)sender {
    textView.textColor = [self randomColor];
}

-(UIColor*)randomColor{
    return [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0  blue:arc4random()%255/255.0 alpha:1];
}

@end

@implementation UIButton (bordered)

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.layer.cornerRadius = 4;
    self.layer.borderColor = UIColorFromRGB(0X333333).CGColor;
    self.layer.borderWidth = 1;
}

-(void)setHighlighted:(BOOL)highlighted{
    if (highlighted) {
        self.backgroundColor = [UIColorFromRGB(0X333333) colorWithAlphaComponent:0.2];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
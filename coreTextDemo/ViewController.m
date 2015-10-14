//
//  ViewController.m
//  coreTextDemo
//
//  Created by roxasora on 15/10/8.
//  https://github.com/Roxasora/RxLabel
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import "ViewController.h"
#import "RxLabel.h"
#import "UIScreen+Additions.h"

@interface ViewController ()<RxLabelDelegate>

- (IBAction)alignSegmentValueChanged:(id)sender;
- (IBAction)fontSizeSliderValueChanged:(id)sender;
- (IBAction)lineSpacingSliderValueChanged:(id)sender;
- (IBAction)linkButtonColorBtnClicked:(id)sender;
- (IBAction)textColorBtnClicked:(id)sender;

@end

@implementation ViewController{
    RxLabel* label;
}

//static NSString* fuckStr = @"http://fuckyourSelf.com 下面我们来尝试完成一个基于 CoreText 的排版引擎。我们将从最简单的排版功能开始，然后逐步支持图文混排，链接点击等功能。http://baidu.com 我乐呵七大时间啊就是控件";
static NSString* textStr = @"http://weibo.com/1694819202 hello Indian MI fans~~~\nExcept normal urls\nthis is a taobao url http://taobao.com this is a Github url https://github.com/Roxasora/RxLabel";
#define fontSize 17
#define lineSpacing 5
#define labelWidth SCREEN_WIDTH - 40
#define margin 20

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height = [RxLabel heightForText:textStr
                                      width:labelWidth
                                       font:[UIFont systemFontOfSize:fontSize]
                                linespacing:lineSpacing];
    
    label = [[RxLabel alloc] initWithFrame:CGRectMake(margin, margin*1.5, labelWidth, height)];
    
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.linespacing = lineSpacing;
    label.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    label.delegate = self;
    
    label.text = textStr;
    
    //if you want to custom the different color and title for particular urls, do like this
    label.customUrlArray = @[
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
                                ];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma label delegate
-(void)RxLabel:(RxLabel *)label didDetectedTapLinkWithUrlStr:(NSString *)urlStr{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"url tapped"
                                                    message:urlStr
                                                   delegate:nil
                                          cancelButtonTitle:@"ok"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - tools action
- (IBAction)alignSegmentValueChanged:(id)sender {
    UISegmentedControl* seg = (UISegmentedControl*)sender;
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            label.textAlignment = NSTextAlignmentLeft;
        }
            break;
        case 1:
        {
            label.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 2:
        {
            label.textAlignment = NSTextAlignmentRight;
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
    
    label.font = [UIFont systemFontOfSize:(16 + fontSizeIncrement)];
    [label sizeToFit];
}

- (IBAction)lineSpacingSliderValueChanged:(id)sender {
    UISlider* slider = (UISlider*)sender;
    CGFloat value = slider.value;
    
    label.linespacing = lineSpacing + value*10;
    [label sizeToFit];
}

- (IBAction)linkButtonColorBtnClicked:(id)sender {
    label.linkButtonColor = [self randomColor];
}

- (IBAction)textColorBtnClicked:(id)sender {
    label.textColor = [self randomColor];
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
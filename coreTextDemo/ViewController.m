//
//  ViewController.m
//  coreTextDemo
//
//  Created by roxasora on 15/10/8.
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import "ViewController.h"
#import "RxTextView.h"
#import "UIScreen+Additions.h"

@interface ViewController ()<RxTextViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnClicked:(id)sender;

@end

@implementation ViewController{
    RxTextView* textView;
}

//static NSString* fuckStr = @"http://fuckyourSelf.com 下面我们来尝试完成一个基于 CoreText 的排版引擎。我们将从最简单的排版功能开始，然后逐步支持图文混排，链接点击等功能。http://baidu.com 我乐呵七大时间啊就是控件";
static NSString* fuckStr = @"http://weibo.com hello, thank you and you??? http://baidu.com";
#define fontSize 17
#define lineSpacing 5

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    fuckStr = @"可是并找不到男票(ಥ_ಥ)的凯撒经典款时间啊肯德基萨克经典款时间啊肯德基萨克基督教阿克江啊对可视对讲卡德加卡萨机读卡";
//    fuckStr = @"(ಥ_ಥ)";
    
    CGFloat height = [RxTextView heightForText:fuckStr width:(SCREEN_WIDTH-60) font:[UIFont systemFontOfSize:fontSize] linespacing:lineSpacing];
    NSLog(@"now height %f",height);
    
    textView = [[RxTextView alloc] initWithFrame:CGRectMake(30, 30, (SCREEN_WIDTH-60), height)];
    textView.textColor = [UIColor grayColor];
    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.linespacing = lineSpacing;
//    textView.linkButtonColor = [UIColor redColor];
    textView.text = fuckStr;
    textView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    textView.delegate = self;
    [self.view addSubview:textView];
    
    
    UIView* heheView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
//    heheView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    [textView addSubview:heheView];
    
    [self.view bringSubviewToFront:self.btn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(id)sender {
    NSLog(@"fuck you ");
    
    CGFloat height = [RxTextView heightForText:fuckStr width:(SCREEN_WIDTH-60) font:[UIFont systemFontOfSize:fontSize] linespacing:lineSpacing];
    textView.frame = CGRectMake(30, 30, (SCREEN_WIDTH - 60), height);
}

-(void)RxTextView:(RxTextView *)textView didDetectedTapLinkWithUrlStr:(NSString *)urlStr{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"url tapped" message:urlStr delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}
@end

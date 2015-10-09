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

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnClicked:(id)sender;

@end

@implementation ViewController{
    RxTextView* textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString* fuckStr = @"http://fuckyourSelf.com 下面我们来尝试完成一个基于 CoreText 的排版引擎。我们将从最简单的排版功能开始，然后逐步支持图文混排，链接点击等功能。http://baidu.com 我乐呵七大时间啊就是控件";
    
    CGFloat height = [RxTextView heightForText:fuckStr width:(SCREEN_WIDTH-60) font:[UIFont systemFontOfSize:18] lineSpacing:0];
    NSLog(@"now height %f",height);
    
    textView = [[RxTextView alloc] initWithFrame:CGRectMake(30, 30, (SCREEN_WIDTH-60), SCREEN_HEIGHT)];
    textView.textColor = [UIColor grayColor];
    textView.font = [UIFont systemFontOfSize:18];
    textView.lineSpacing = 0;
    textView.text = fuckStr;
    textView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:textView];
    
    UIView* heheView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    heheView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
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
    textView.lineSpacing = 0;
}
@end

# RxTextView

##it's a custom UITextView that could detect urls and replace them with buttons,just like weico/vvebo apps,used coreText.

like the screen shot

![image](http://img.hb.aicdn.com/4480f54604e65ac07eea9286f4f2d2063930a7a5f0d1-K5LMRV_fw658)

### usage
you can use it just like a UITextView
   
		NSString* textStr = @"http://weibo.com/1694819202 hello Indian MI fans~~~\nExcept normal urls\nthis is a taobao url http://taobao.com this is a Github url https://github.com/Roxasora/RxTextView";
		CGFloat height = [RxTextView heightForText:textStr width:(SCREEN_WIDTH-60) font:[UIFont systemFontOfSize:16] 			linespacing:5];
		textView = [[RxTextView alloc] initWithFrame:CGRectMake(30, 30, (SCREEN_WIDTH-60), height)];
		textView.textColor = [UIColor grayColor];
		textView.font = [UIFont systemFontOfSize:16];
		textView.linespacing = 5;
		textView.linkButtonColor = [UIColor redColor];
		textView.text = textStr;
		textView.textAlignment = NSTextAlignmentLeft;
		textView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
		textView.delegate = self;
		
		[self.view addSubview:textView];

###//and if you want to have custom buttons
		textView.urlCustomArray = [@[
                                @{
                                    @"scheme":@"taobao",
                                    @"title":@"淘宝",
                                    @"color":@0XF97840
                                    },
                                @{
                                    @"scheme":@"douban",
                                    @"title":@"豆瓣",
                                    @"color":@0X72E073
                                    }
                                ] mutableCopy];

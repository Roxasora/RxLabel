# RxTextView

##it's a custom UITextView that could detect urls and replace them with buttons,just like weico/vvebo apps,used coreText.

like the screen shot

![image](http://img.hb.aicdn.com/e0184526e5a4355fe8374b6cd01ffc9ea56973529276-32CcAY_fw658)

### usage
you can use it just like a UITextView
   
		NSString* textStr = @"http://weibo.com hello, thank you and you??? http://baidu.com";
		CGFloat height = [RxTextView heightForText:textStr width:(SCREEN_WIDTH-60) font:[UIFont systemFontOfSize:16] 			linespacing:5];
		textView = [[RxTextView alloc] initWithFrame:CGRectMake(30, 30, (SCREEN_WIDTH-60), height)];
		textView.textColor = [UIColor grayColor];
		textView.font = [UIFont systemFontOfSize:16];
		textView.linespacing = 5;
		textView.linkButtonColor = [UIColor redColor];
		textView.text = textStr;
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

# RxTextView

##it's a custom UITextView that could detect urls and replace them with buttons,just like weico/vvebo apps,used coreText.



like the screen shot gif

![image](http://img.hb.aicdn.com/85a530455028b783b8d33c966ff9a11e06b9a5bf58397-kCYPn5_fw658)

### usage

####Install
You just need to drag/copy the "RxTextView" folder and drop in your project

####properties

you can use it just like a UITextView
   
		NSString* textStr = @"http://weibo.com/1694819202 hello Indian MI fans~~~\nExcept normal urls\nthis is a taobao url http://taobao.com this is a Github url https://github.com/Roxasora/RxTextView";
		
		//You can get the height of textview with configs easily
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

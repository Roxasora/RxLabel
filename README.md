# RxTextView

###it's a custom UITextView that could detect urls and replace them with buttons,just like weico/vvebo apps,used coreText.
###使用 coretext 编写的自定义textView，实现像weico/vvebo一样将url转变为一个按钮，按钮可点击，高度随字体自适应变化，并且可以自定义特定urlScheme的特定按钮颜色和title文字，可根据文字获取高度，使用方式如同UITextView一样方便 


like the screen shot gif

![image](http://img.hb.aicdn.com/d7a44891e4c71a26743f9528e4b4124baacb50338c0f8-LTlQMJ_fw658)

### usage使用

####Install（ARC）安装（ARC）
You just need to drag/copy the "RxTextView" folder and drop in your project
将“RxTextView”文件夹拖进你的工程中即可

####properties 属性设置


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

####You can get the height of textview with configs easily 根据内容，字体，行高等配置获取高度
		CGFloat height = [RxTextView heightForText:textStr width:(SCREEN_WIDTH-60) font:[UIFont systemFontOfSize:16] 			linespacing:5];
####and if you want to have custom link buttons 创建根据scheme自定义颜色和标题的 url 按钮
watch out ,you should use hex color for custom link button
注意这里的颜色值使用16进制颜色值，为了方便使用
		textView.customUrlArray = [@[
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
                                
                                
####url tapped delegate url按钮点击的代理方法
		-(void)RxTextView:(RxTextView *)textView didDetectedTapLinkWithUrlStr:(NSString *)urlStr{
    		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"url tapped" message:urlStr delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    		[alert show];
		}
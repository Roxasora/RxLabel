# Rxlabel

###it's a custom UILabel that could detect urls and replace them with buttons,just like weico/vvebo apps,used coreText.
###使用 coretext 编写的自定义UILabel，实现像weico/vvebo一样将url转变为一个按钮，按钮可点击，高度随字体自适应变化，并且可以自定义特定urlScheme的特定按钮颜色和title文字，可根据文字获取高度，使用方式如同UILabel一样方便 


like the screen shot gif

![image](http://img.hb.aicdn.com/d7a44891e4c71a26743f9528e4b4124baacb50338c0f8-LTlQMJ_fw658)

### usage使用

####Install 安装
You just need to drag/copy the "RxLabel" folder and drop in your project
将“Rxlabel”文件夹拖进你的工程中即可

####properties 属性设置


you can use it just like a UILabel
   
		NSString* textStr = @"http://weibo.com/1694819202 hello Indian MI fans~~~\nExcept normal urls\nthis is a taobao url http://taobao.com this is a Github url https://github.com/Roxasora/Rxlabel";
		
		CGFloat height = [RxLabel heightForText:textStr width:(SCREEN_WIDTH-60) font:[UIFont systemFontOfSize:16] linespacing:5];
		
		label = [[RxLabel alloc] initWithFrame:CGRectMake(30, 30, (SCREEN_WIDTH-60), height)];
		label.textColor = [UIColor grayColor];
		label.font = [UIFont systemFontOfSize:16];
		label.linespacing = 5;
		label.linkButtonColor = [UIColor redColor];
		label.text = textStr;
		label.textAlignment = NSTextAlignmentLeft;
		label.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
		label.delegate = self;
		
		[self.view addSubview:label];

####You can get the height of label with configs easily 根据内容，字体，行高等配置获取高度
		CGFloat height = [RxLabel heightForText:@"我到河北省来"
                                      width:200
                                       font:[UIFont systemFontOfSize:16]
                                linespacing:5];
####and if you want to have custom link buttons 创建根据scheme自定义颜色和标题的 url 按钮
watch out ,you should use hex color for custom link button
注意这里的颜色值使用16进制颜色值，为了方便使用

		label.customUrlArray = [@[
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
                                
                                
####url tapped delegate url按钮点击的代理方法
		-(void)RxLabel:(RxLabel *)label didDetectedTapLinkWithUrlStr:(NSString *)urlStr{
    		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"url tapped"
                                                    message:urlStr
                                                   delegate:nil
                                          cancelButtonTitle:@"ok"
                                          otherButtonTitles:nil];
    		[alert show];
		}
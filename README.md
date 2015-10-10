# RxTextView

##it's a custom UITextView that could detect urls and replace them with buttons,just like weico/vvebo apps,used coreText.

like the screen shot

![image](http://img.hb.aicdn.com/844c8e384516f23d409ea8166a385924625af4efc8a1-e4Rnl3_fw658 =320x568)

### usage
you can use it just like a UITextView
   
<code>
	textView = [[RxTextView alloc] initWithFrame:CGRectMake(30, 30, (SCREEN_WIDTH-60), height)];
    textView.textColor = [UIColor grayColor];
    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.linespacing = lineSpacing;
    textView.linkButtonColor = [UIColor redColor];
    textView.text = fuckStr;
    textView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    textView.delegate = self;
    [self.view addSubview:textView];
</code>

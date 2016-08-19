//
//  AppDelegate.h
//  JavaScript
//
//  Created by zhangferry on 16/8/18.
//  Copyright © 2016年 com.fly All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(void)viewDidAppear:(BOOL)animated{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.webView.delegate = self;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context[@"Native"] = self;
//    第二种测试
//    self.context[@"alertShow"] = ^(NSString *str){
//        
//        NSLog(@"%@",str);
//    };
    
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}
/* webview 每当需要去加载一个 request 就先回调这个方法,让上层决定是否 加载。一般在这里截获,进行本地的处理。 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *url = request.URL.absoluteString;
    NSLog(@"____%@",url);
    BOOL isNetwork;
    if(!isNetwork){
        //无网情况的一个处理
    }else if([url hasSuffix:@"ios/test"]){
    
        //do something you want return NO
    }
    return YES;
}

- (void)call:(NSString *)str{
    NSLog(@"call");
    // 之后在回调js的方法alertShow把内容传出去
    JSValue *Callback = self.context[@"alertShow"];
    //JSValue *Callback = [self.context objectForKeyedSubscript:@"alertShow"];
    //传值给web端
    [Callback callWithArguments:@[@"OC调用JS方法"]];//参数，数组形式
    
}

//外部函数调用
- (void)callJS{
    
    NSString *str = @"alert('OC添加JS提示成功')";
    [self.context evaluateScript:str];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

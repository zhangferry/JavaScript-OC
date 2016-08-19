//
//  AppDelegate.h
//  JavaScript
//
//  Created by zhangferry on 16/8/18.
//  Copyright © 2016年 com.fly All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>

- (void)call:(NSString *)str;

@end
@interface ViewController : UIViewController<UIWebViewDelegate,JSObjcDelegate>
@property (nonatomic, strong) JSContext *context;
@property (strong, nonatomic)  UIWebView *webView;

@end


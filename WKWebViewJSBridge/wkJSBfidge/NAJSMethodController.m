//
//  NAJSMethodController.m
//  WKWebViewJSBridge
//
//  Created by mayzh on 7/3/20.
//  Copyright © 2020 My. All rights reserved.
//

#import "NAJSMethodController.h"
#import "CallWebJSController.h"
#import "GNAJSMethodsManager.h"


@interface NAJSMethodController ()
@property (nonatomic, weak) CallWebJSController *webJSController;
@end

@implementation NAJSMethodController

- (void)dealloc {
    NSLog(@"NAJSMethodController--dealloc");
}

- (void)insertCallBackToWebJSController:(CallWebJSController *)webJSController {
    self.webJSController = webJSController;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary * parameter = message.body;
    NSString *methodName = parameter[@"methodName"];
    NSString *nativeMethodName = message.name;
    if (![nativeMethodName isEqualToString:[GNAJSMethodsManager globalBaseNativeMethodName4JS]]) {
        return;
    }
    if (!methodName.length) {
        return;
    }

    [self.webJSController callWebViewPrintData];
//    if (condition) {
//        <#statements#>
//    }
//    if ([methodName isEqualToString:@"downMethod"]) {
//        //收到js调用的downMethod方法后
//
//    }
}

@end

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
@property (nonatomic, strong) GNAJSMethodsManager *nsjsMethodsManager;
@end

@implementation NAJSMethodController

- (instancetype)init {
    self = [super init];
    if (self) {
        _nsjsMethodsManager = [[GNAJSMethodsManager alloc] init];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"NAJSMethodController--dealloc");
}

- (void)insertCallBackToWebJSController:(CallWebJSController *)webJSController {
    self.webJSController = webJSController;
    self.nsjsMethodsManager.webJSController = self.webJSController;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {

    NSString *nativeMethodName = message.name;
    if (![nativeMethodName isEqualToString:[GNAJSMethodsManager globalBaseNativeMethodName4JS]] && ![nativeMethodName isEqualToString:@"ThrowEvent"]) {
        return;
    }

    NSDictionary * parameter = message.body;
    NSString *methodName = parameter[@"methodName"];
    NSDictionary *methodParam = parameter[@"param"];
    NSString *methodCB = parameter[@"JSCallBack"];
    if (!methodName.length) {
        return;
    }

    NSString *methodRightPart = @":callBack:";
    NSString *fullMethodName = [NSString stringWithFormat:@"%@%@", methodName,methodRightPart];
    SEL selector = NSSelectorFromString(fullMethodName);

    if (self.nsjsMethodsManager && [self.nsjsMethodsManager respondsToSelector:selector]) {
        IMP imp = [self.nsjsMethodsManager methodForSelector:selector];
        void (*func)(id, SEL, id, id) = (void *)imp;
        func(self.nsjsMethodsManager, selector, methodParam, methodCB);
    } 

    [self.webJSController callWebViewPrintData];
}

@end

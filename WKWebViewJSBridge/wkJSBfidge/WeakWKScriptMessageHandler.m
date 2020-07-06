//
//  WeakWKScriptMessageHandler.m
//  WKWebViewJSBridge
//
//  Created by ma on 7/1/20.
//  Copyright © 2020 My. All rights reserved.
//

#import "WeakWKScriptMessageHandler.h"


@interface WeakWKScriptMessageHandler ()
//这个wkScriptDelegate弱引用当前webViewNA方法的具体执行者，避免不能释放问题
@property (nonatomic, weak) id <WKScriptMessageHandler> wkScriptDelegate;
@end


@implementation WeakWKScriptMessageHandler

- (void)dealloc {
    NSLog(@"WeakWKScriptMessageHandler--dealloc");
}


- (instancetype)initWithDelegate:(id <WKScriptMessageHandler>) wkScriptDelegate {
    self = [super init];
    if (self) {
        _wkScriptDelegate = wkScriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([self.wkScriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.wkScriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end

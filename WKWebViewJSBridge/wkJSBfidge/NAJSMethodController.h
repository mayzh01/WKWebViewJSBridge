//
//  NAJSMethodController.h
//  WKWebViewJSBridge
//
//  Created by mayzh on 7/3/20.
//  Copyright © 2020 My. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <WebKit/WebKit.h>


@class CallWebJSController;

NS_ASSUME_NONNULL_BEGIN

@interface NAJSMethodController : NSObject <WKScriptMessageHandler>
- (void)insertCallBackToWebJSController:(CallWebJSController *)webJSController;
@end

NS_ASSUME_NONNULL_END

//
//  WeakWKScriptMessageHandler.h
//  WKWebViewJSBridge
//
//  Created by ma on 7/1/20.
//  Copyright © 2020 My. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakWKScriptMessageHandler : NSObject <WKScriptMessageHandler>
- (instancetype)initWithDelegate:(id <WKScriptMessageHandler>) wkScriptDelegate;
@end

NS_ASSUME_NONNULL_END

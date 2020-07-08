//
//  GNAJSMethodsManager.h
//  WKWebViewJSBridge
//
//  Created by mayzh on 7/6/20.
//  Copyright © 2020 My. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


extern NSString *MAUDScriptObj_TONA_MouseDown;


@class CallWebJSController;

@interface GNAJSMethodsManager : NSObject
@property (nonatomic, weak) CallWebJSController *webJSController;
+ (NSString *)globalBaseNativeMethodName4JS;
- (void)MAUDScriptObj_TONA_MouseDown:(NSDictionary *)param callBack:(NSString *)cbJSMethodName;
@end

NS_ASSUME_NONNULL_END

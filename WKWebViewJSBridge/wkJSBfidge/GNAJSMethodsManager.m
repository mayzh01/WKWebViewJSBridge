//
//  GNAJSMethodsManager.m
//  WKWebViewJSBridge
//
//  Created by mayzh on 7/6/20.
//  Copyright © 2020 My. All rights reserved.
//

#import "GNAJSMethodsManager.h"
#import "CallWebJSController.h"


const NSString *MAUDScriptObj_TONA_MouseDown = @"MAUDScriptObj_TONA_MouseDown";


@interface GNAJSMethodsManager ()
@end

@implementation GNAJSMethodsManager

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (NSString *)globalBaseNativeMethodName4JS {
    return @"callNativeMethod";
}

- (void)MAUDScriptObj_TONA_MouseDown:(NSDictionary *)param callBack:(NSString *)cbJSMethodName {
    do {
        NSLog(@"NA received mouse down event");
    } while (0);

    if (cbJSMethodName.length && self.webJSController) {
        NSLog(@"call back to js");
        [self.webJSController callBackTOWebView:cbJSMethodName params:@[cbJSMethodName]];
    }
}

@end


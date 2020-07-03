//
//  WKWindowController.h
//  WKWebViewJSBridge
//
//  Created by ma on 6/29/20.
//  Copyright © 2020 My. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WKWindowController <NSObject>

- (void)windowWillClose;

@end

@interface WKWindowController : NSWindowController

@property (nonatomic, weak) id<WKWindowController> closeDelegate;

@end

NS_ASSUME_NONNULL_END

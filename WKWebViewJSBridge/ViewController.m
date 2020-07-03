//
//  ViewController.m
//  WKWebViewJSBridge
//
//  Created by ma on 6/29/20.
//  Copyright © 2020 My. All rights reserved.
//

#import "ViewController.h"
#import "WKWindowController.h"

@interface ViewController () <WKWindowController>

@property (nonatomic, strong) WKWindowController *wkwc;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.btn = [NSButton buttonWithTitle:@"open" target:self action:@selector(openWC)];
    [self.view addSubview:self.btn];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)openWC {
    if (!self.wkwc) {
        self.wkwc = [[WKWindowController alloc] initWithWindowNibName:@"WKWindowController"];
        self.wkwc.closeDelegate = self;
//        [self.wkwc.window setReleasedWhenClosed:YES];
    }
    [self.wkwc showWindow:nil];
}

- (void)windowWillClose {
    self.wkwc = nil;
}

@end

//
//  UIWebViewEX.m
//  TestWebView
//
//  Created by LamBao on 1/21/15.
//  Copyright (c) 2015 LamBao. All rights reserved.
//

#import "UIWebViewEX.h"

@implementation UIWebViewEX

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) init {
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@" Init");
        self.delegate = self;
    }
    return self;
    CGPoint currentOffset = self.scrollView.contentOffset;
    [self.scrollView setContentOffset:CGPointMake(currentOffset.x, currentOffset.y +1) animated:NO];
    [self.scrollView setContentOffset:currentOffset animated:NO];
}



#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStart: self %@ -  webview: %@", self, webView );
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end

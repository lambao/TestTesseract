//
//  BrowserViewController.m
//  TestWebView
//
//  Created by LamBao on 1/21/15.
//  Copyright (c) 2015 LamBao. All rights reserved.
//

#import "BrowserViewController.h"
#import "UIWebViewEX.h"

@interface BrowserViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *activeWebView;

@property (strong, nonatomic) NSMutableArray *windows;

@end

@implementation BrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _windows = [[NSMutableArray alloc] init];
    
    UIWebViewEX *webview = [[UIWebViewEX alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    [_windows addObject:webview];
    
    NSLog(@"webview :%@", webview);
          
    UIWebViewEX *webview1 = [[UIWebViewEX alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    [_windows addObject:webview1];
    NSLog(@"webview1 :%@", webview1);
    
    self.activeWebView = webview;
    
    [self.view addSubview:_activeWebView];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://mail.google.com"]];
    
    [_activeWebView loadRequest:req];
    
    
    // Create your G8Tesseract object using the initWithLanguage method:
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
    
    // Optionaly: You could specify engine to recognize with.
    // G8OCREngineModeTesseractOnly by default. It provides more features and faster
    // than Cube engine. See G8Constants.h for more information.
    //tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Set up the delegate to receive Tesseract's callbacks.
    // self should respond to TesseractDelegate and implement a
    // "- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract"
    // method to receive a callback to decide whether or not to interrupt
    // Tesseract before it finishes a recognition.
    tesseract.delegate = self;
    
    // Optional: Limit the character set Tesseract should try to recognize from
    tesseract.charWhitelist = @"0123456789";
    
    // This is wrapper for common Tesseract variable kG8ParamTesseditCharWhitelist:
    // [tesseract setVariableValue:@"0123456789" forKey:kG8ParamTesseditCharBlacklist];
    // See G8TesseractParameters.h for a complete list of Tesseract variables
    
    // Optional: Limit the character set Tesseract should not try to recognize from
    //tesseract.charBlacklist = @"OoZzBbSs";
    
    // Specify the image Tesseract should recognize on
    tesseract.image = [[UIImage imageNamed:@"test.png"] g8_blackAndWhite];
    
    // Optional: Limit the area of the image Tesseract should recognize on to a rectangle
    tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Optional: Limit recognition time with a few seconds
    tesseract.maximumRecognitionTime = 2.0;
    
    // Start the recognition
    [tesseract recognize];
    
    // Retrieve the recognized text
    NSLog(@"%@", [tesseract recognizedText]);
    
    // You could retrieve more information about recognized text with that methods:
    NSArray *characterBoxes = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelSymbol];
    NSArray *paragraphs = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelParagraph];
    NSArray *characterChoices = tesseract.characterChoices;
    UIImage *imageWithBlocks = [tesseract imageWithBlocks:characterBoxes drawText:YES thresholded:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to interrupt tesseract before it finishes
}

@end

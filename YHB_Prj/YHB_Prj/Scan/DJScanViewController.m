//
//  DJScanViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 15/9/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "DJScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DJStoryboadManager.h"
#import "DJInputCodeViewController.h"

#define kButtonWidth 180
#define kButtonHeight 40
#define kScanWidth 250

@interface DJScanViewController()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, assign) BOOL                  isReading;
@property (nonatomic, strong) AVCaptureSession *    captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, assign) CGRect                scanRect;

@end;

@implementation DJScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initailUI];
    if (![self startReading]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)initailUI {
    [self addShape];
    
    self.title = @"商品扫码";
    UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, kMainScreenWidth, 20)];
    Label.backgroundColor = [UIColor clearColor];
    [Label setTextAlignment:NSTextAlignmentCenter];
    Label.font = kFont16;
    Label.text= @"请将您的摄像头对准条码";
    Label.textColor = [UIColor whiteColor];
    [self.view addSubview:Label];
    
    UIButton *inputNumButton = [[UIButton alloc] initWithFrame:CGRectMake((kMainScreenWidth-kButtonWidth)/2., kMainScreenHeight-20-44-kButtonHeight-30, kButtonWidth, kButtonHeight)];
    [inputNumButton setBackgroundColor:KColor];
    [inputNumButton setTitle:@"手工输入条码" forState:UIControlStateNormal];
    [inputNumButton addTarget:self action:@selector(inputNum:) forControlEvents:UIControlEventTouchUpInside];
    inputNumButton.layer.cornerRadius = 4.;
    [self.view addSubview:inputNumButton];
}

- (void)inputNum: (UIButton *)sender {
    DJInputCodeViewController *vc = (DJInputCodeViewController *)[[DJStoryboadManager sharedInstance] viewControllerWithName:@"DJInputCodeViewController"];
    __weak typeof(self) weakself = self;
    [vc setSHandler:^(NSString *codeStr){
        if (codeStr.length) {
            if ([weakself.delegate respondsToSelector:@selector(scanController:didScanedAndTransToMessage:)]) {
                [weakself.delegate scanController:weakself didScanedAndTransToMessage:codeStr];
            }
        }
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)startReading {
    if (_isReading) {
        return YES;
    }
    _isReading = YES;
    NSError *error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    NSLog(@"%@ %@",[NSValue valueWithCGRect:self.view.frame],[NSValue valueWithCGRect:self.scanRect]);
    //优化
    CGFloat x = self.scanRect.origin.x / self.view.width;

    CGFloat y = (self.scanRect.origin.y) / self.view.height;
    CGFloat width = self.scanRect.size.width / self.view.width;
    CGFloat height = self.scanRect.size.height / self.view.height;
    [captureMetadataOutput setRectOfInterest:CGRectMake(y, x, height, width)];
    
    
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.view.layer.bounds];
    [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];//:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    return YES;
}

- (void)addShape {
    CGFloat x = (kMainScreenWidth - kScanWidth) / 2.;
    CGFloat y = 40 + 40;
    self.scanRect = CGRectMake(x, y, kScanWidth, kScanWidth);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, self.view.bounds);
    CGPathAddRect(path, nil, self.scanRect);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.fillColor = RGBACOLOR(0, 0, 0, 0.7).CGColor;
    [shapeLayer setFillRule:@"even-odd"];
   // shapeLayer.lineWidth = 1;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path;

    [self.view.layer addSublayer:shapeLayer];


    
    CGPathRelease(path);
}


-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
    _isReading = NO;
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (!_isReading) return;
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSLog(@"扫描到的信息%@",metadataObj.stringValue);
        if ([self.delegate respondsToSelector:@selector(scanController:didScanedAndTransToMessage:)]) {
            [self stopReading];
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate scanController:self didScanedAndTransToMessage:metadataObj.stringValue];
        }
    }
}

@end

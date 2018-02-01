//
//  ViewController.m
//  YGCTrimVideoViewDemo
//
//  Created by Qilong Zang on 01/02/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import "ViewController.h"
#import "YGCTrimVideoView.h"

@interface ViewController ()<YGCTrimVideoViewDelegate>
@property (nonatomic, strong) YGCTrimVideoView *ygcTrimView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zuxian"
                                                     ofType:@"MP4"];
    self.ygcTrimView = [[YGCTrimVideoView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 75, self.view.bounds.size.width, 75)
                                                       assetUR:[NSURL fileURLWithPath:path]];
    self.ygcTrimView.delegate = self;
    [self.view addSubview:self.ygcTrimView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Delegate

- (void)videoBeginTimeChanged:(CMTime)begin timeCroppedAsset:(AVMutableComposition *)asset {

}

- (void)videoEndTimeChanged:(CMTime)end timeCroppedAsset:(AVMutableComposition *)asset {

}

- (IBAction)generatorVideo:(id)sender {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

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
@property (weak, nonatomic) IBOutlet UIView *previewContainer;
@property (nonatomic, strong) YGCTrimVideoView *ygcTrimView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *originItem;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zuxian"
                                                     ofType:@"MP4"];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:path] options:nil];
    self.originItem = [[AVPlayerItem alloc] initWithAsset:asset];
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.originItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.previewContainer.layer addSublayer:self.playerLayer];
    self.ygcTrimView = [[YGCTrimVideoView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 75, self.view.bounds.size.width, 75)
                                                       assetURL:[NSURL fileURLWithPath:path]];
    self.ygcTrimView.delegate = self;
    [self.view addSubview:self.ygcTrimView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player play];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.playerLayer.frame = self.previewContainer.bounds;
}

#pragma mark - Delegate

- (void)videoBeginTimeChanged:(CMTime)begin {
    if ([self.player currentItem] != self.originItem) {
        [self.player replaceCurrentItemWithPlayerItem:self.originItem];
    }
    [self.player seekToTime:begin completionHandler:^(BOOL finished) {

    }];
}

- (void)videoEndTimeChanged:(CMTime)end {
    if ([self.player currentItem] != self.originItem) {
        [self.player replaceCurrentItemWithPlayerItem:self.originItem];
    }
    [self.player seekToTime:end completionHandler:^(BOOL finished) {

    }];
}

- (void)dragActionEnded:(AVMutableComposition *)asset {
    self.playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self.player play];

}

- (IBAction)generatorVideo:(id)sender {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

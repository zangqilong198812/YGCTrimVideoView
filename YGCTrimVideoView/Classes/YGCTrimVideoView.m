//
//  YGCTrimVideoView.m
//  VideoTrimView
//
//  Created by Qilong Zang on 30/01/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import "YGCTrimVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import "YGCTrimVideoControlView.h"
#import "YGCThumbCollectionViewCell.h"
#import "UIView+YGCFrameUtil.h"

//static NSInteger const kMaxThumbCount = 30;
static CGFloat const kDefaultSidebarWidth = 12;
static CGFloat const kDefaultMaxSeconds = 10;
static CGFloat const kDefaultMinSeconds = 2;
static NSString * const kCellIdentifier = @"YGCThumbCollectionViewCell";

@interface YGCTrimVideoView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *thumbCollectionView;
@property (nonatomic, strong) YGCTrimVideoControlView *controlView;
@property (nonatomic, assign) CGFloat controlInset;
@property (nonatomic, strong) AVURLAsset *asset;
@property (nonatomic, strong) AVAssetImageGenerator *imageGenerator;
@property (nonatomic, strong) NSMutableArray<UIImage *> *thumbImageArray;
@property (nonatomic, strong) NSMutableArray<NSValue *> *timeArray;

@end

@implementation YGCTrimVideoView

- (id)initWithFrame:(CGRect)frame
            assetUR:(NSURL *)url
{
    return [self initWithFrame:frame
                       assetUR:url
              leftSidebarImage:nil
             rightSidebarImage:nil
              centerRangeImage:nil
                  sidebarWidth:kDefaultSidebarWidth
              controlViewInset:20];
}


- (id)initWithFrame:(CGRect)frame
            assetUR:(NSURL *)url
   leftSidebarImage:(UIImage *)leftImage
  rightSidebarImage:(UIImage *)rightImage
   centerRangeImage:(UIImage *)centerImage
       sidebarWidth:(CGFloat)width
   controlViewInset:(CGFloat)inset
{
    if (self = [super initWithFrame:frame]) {

        self.asset = [[AVURLAsset alloc] initWithURL:url options:nil];
        self.controlInset = inset;
        self.leftSidebarImage = leftImage;
        self.rightSidebarImage = rightImage;
        self.centerRangeImage = centerImage;
        self.sidebarWidth = width;
        self.thumbImageArray = [NSMutableArray array];
        self.timeArray = [NSMutableArray array];
        self.maxSeconds = kDefaultMaxSeconds;
        self.minSeconds = kDefaultMinSeconds;
        [self commonInit];
        [self generateVideoThumb];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:self.thumbCollectionView];
    [self addSubview:self.controlView];

    [self.thumbCollectionView registerClass:[YGCThumbCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
}

- (NSTimeInterval)pixelSeconds {
    return self.maxSeconds/self.controlView.ygc_width;
}

- (NSTimeInterval)cellTime {
    return [self pixelSeconds] * [self cellWidth];;
}

- (CGFloat)cellWidth {
    return self.controlView.ygc_width/10;
}

#pragma mark - Getter

- (YGCTrimVideoControlView *)controlView {
    if (_controlView == nil) {
        _controlView = [[YGCTrimVideoControlView alloc] initWithFrame:CGRectInset(self.bounds, self.controlInset, 0) leftControlImage:self.leftSidebarImage rightControlImage:self.rightSidebarImage centerRangeImage:self.centerRangeImage sideBarWidth:self.sidebarWidth];
    }
    return _controlView;
}

- (UICollectionView *)thumbCollectionView {
    if (_thumbCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _thumbCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _thumbCollectionView.delegate = self;
        _thumbCollectionView.dataSource = self;
    }
    return _thumbCollectionView;
}

- (AVAssetImageGenerator *)imageGenerator {
    if (_imageGenerator == nil) {
        _imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:self.asset];
        _imageGenerator.maximumSize = CGSizeMake(80, 80);
        _imageGenerator.appliesPreferredTrackTransform = YES;
    }
    return _imageGenerator;
}

#pragma mark - Setter

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    self.controlView.maskColor = _maskColor;
}

- (void)setMaxSeconds:(NSTimeInterval)maxSeconds {
    _maxSeconds = maxSeconds;
    NSTimeInterval duration = CMTimeGetSeconds(self.asset.duration);
    if (duration < _maxSeconds) {
        _maxSeconds = duration;
    }
}

#pragma mark - CollectionView DataSource

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YGCThumbCollectionViewCell *thumbCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    thumbCell.thumbImageView.image = self.thumbImageArray[indexPath.row];
    return thumbCell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.thumbImageArray.count;
}

#pragma mark - CollectionViewFlowLayout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.cellWidth, self.ygc_height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, self.controlInset, 0, 0);
}

#pragma mark - Private Method

- (void)generateVideoThumb {
    CMTimeScale timeScale = self.asset.duration.timescale;

    self.controlView.mininumTimeWidth = self.minSeconds/[self pixelSeconds];

    NSInteger thumbNumber = CMTimeGetSeconds(self.asset.duration)/[self cellTime];
    for (int i = 0; i<thumbNumber; i++) {
        CMTime time = CMTimeMakeWithSeconds([self cellTime] * i, timeScale);
        NSValue *value = [NSValue valueWithCMTime:time];
        [self.timeArray addObject:value];
    }

    [self.imageGenerator generateCGImagesAsynchronouslyForTimes:self.timeArray completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        if (error == nil && result == AVAssetImageGeneratorSucceeded) {
            [self.thumbImageArray addObject:[UIImage imageWithCGImage:image]];
            dispatch_async(dispatch_get_main_queue(), ^{

                [self.thumbCollectionView reloadData];
            });
        }
    }];
}

//- (AVMutableComposition *)trimVideo {
//    AVAssetTrack *assetVideoTrack = nil;
//    AVAssetTrack *assetAudioTrack = nil;
//    AVURLAsset *asset = self.asset;
//    // Check if the asset contains video and audio tracks
//    if ([[asset tracksWithMediaType:AVMediaTypeVideo] count] != 0) {
//        assetVideoTrack = [asset tracksWithMediaType:AVMediaTypeVideo][0];
//    }
//    if ([[asset tracksWithMediaType:AVMediaTypeAudio] count] != 0) {
//        assetAudioTrack = [asset tracksWithMediaType:AVMediaTypeAudio][0];
//    }
//
//    CGFloat leftPosition = self.thumbCollectionView.contentOffset.x + self.controlView.leftControlView.frame.origin.x;
//    CGFloat rightPosition = self.thumbCollectionView.contentOffset.x + CGRectGetMaxX(self.controlView.rightControlView.frame);
//    CGFloat startSec = leftPosition * _pixelPerSecond;
//    CGFloat endSec = rightPosition * _pixelPerSecond;
//    CMTime startTime = CMTimeMakeWithSeconds(startSec, self.asset.duration.timescale);
//    CMTime endTime = CMTimeMakeWithSeconds(endSec, self.asset.duration.timescale);
//    CMTimeRange cutRange = CMTimeRangeMake(CMTimeMakeWithSeconds(startSec, self.asset.duration.timescale), CMTimeMakeWithSeconds(endSec, self.asset.duration.timescale));
//
//
//    NSError *error = nil;
//
//
//
//    // Step 1
//    //  Create a composition with the given asset and insert audio and video tracks for half the duration into it from the asset
//    self.mutableComposition = [AVMutableComposition composition];
//
//    // Insert half time range of the video and audio tracks from AVAsset
//    if(assetVideoTrack != nil) {
//        AVMutableCompositionTrack *compositionVideoTrack = [self.mutableComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
//        [compositionVideoTrack insertTimeRange:cutRange ofTrack:assetVideoTrack atTime:kCMTimeZero error:&error];
//        [compositionVideoTrack setPreferredTransform:assetVideoTrack.preferredTransform];
//    }
//    if(assetAudioTrack != nil) {
//        AVMutableCompositionTrack *compositionAudioTrack = [self.mutableComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
//        [compositionAudioTrack insertTimeRange:cutRange ofTrack:assetAudioTrack atTime:kCMTimeZero error:&error];
//    }
//
//    CMTime acturalDuraton = CMTimeSubtract(endTime, startTime);
//    [_mutableComposition removeTimeRange:CMTimeRangeMake(acturalDuraton, _mutableComposition.duration)];
//
//    NSString *tmpFile = [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), @"output.mov"];
//    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:_mutableComposition presetName:AVAssetExportPresetHighestQuality];
//    session.outputURL = [NSURL fileURLWithPath:tmpFile];
//    session.outputFileType = AVFileTypeQuickTimeMovie;
//    [session exportAsynchronouslyWithCompletionHandler:^{
//        if (session.status == AVAssetExportSessionStatusCompleted) {
//            NSLog(@"success,%@", tmpFile);
//        }
//    }];
//    return _mutableComposition;
//}

@end

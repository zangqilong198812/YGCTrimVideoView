//
//  YGCTrimVideoView.h
//  VideoTrimView
//
//  Created by Qilong Zang on 30/01/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol YGCTrimVideoViewDelegate <NSObject>

- (void)videoBeginTimeChanged:(CMTime)begin timeCroppedAsset:(AVMutableComposition *)asset;

- (void)videoEndTimeChanged:(CMTime)end timeCroppedAsset:(AVMutableComposition *)asset;

@end

@interface YGCTrimVideoView : UIView

@property (nonatomic, weak) id<YGCTrimVideoViewDelegate> delegate;

@property (nonatomic, strong, readonly) AVMutableComposition *currentAsset;

/*
 * change the sidebar width
 */
@property (nonatomic, assign) CGFloat sidebarWidth;

/*
 * change the left sidebar Image
 */
@property (nonatomic, strong) UIImage *leftSidebarImage;

/*
 * change the right sidebar Image
 */
@property (nonatomic, strong) UIImage *rightSidebarImage;

/*
 * change the center range Image
 */
@property (nonatomic, strong) UIImage *centerRangeImage;

/*
 * change the maximum duration of video
 */
@property (nonatomic, assign) NSTimeInterval maxSeconds;

/*
 * change the minimum duration of video
 */
@property (nonatomic, assign) NSTimeInterval minSeconds;

/*
 * change the left and right side maskView when slider range decrease
 */
@property (nonatomic, strong) UIColor *maskColor;

- (id)initWithFrame:(CGRect)frame
            assetUR:(NSURL *)url;

- (id)initWithFrame:(CGRect)frame
            assetUR:(NSURL *)url
   leftSidebarImage:(UIImage *)leftImage
  rightSidebarImage:(UIImage *)rightImage
   centerRangeImage:(UIImage *)centerImage
       sidebarWidth:(CGFloat)width
   controlViewInset:(CGFloat)inset;

- (void)exportVideo;

@end

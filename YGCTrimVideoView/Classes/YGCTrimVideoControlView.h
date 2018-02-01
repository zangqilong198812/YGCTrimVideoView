//
//  YGCTrimVideoControlView.h
//  VideoTrimView
//
//  Created by Qilong Zang on 30/01/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YGCTrimVideoControlViewDelegate <NSObject>

- (void)leftSideBarChangedFrame:(CGRect)leftFrame rightBarCurrentFrame:(CGRect)rightFrame;

- (void)rightSideBarChangedFrame:(CGRect)rightFrame leftBarCurrentFrame:(CGRect)leftFrame;

- (void)panGestureEnded:(CGRect)leftFrame rightFrame:(CGRect)rightFrame;

@end

@interface YGCTrimVideoControlView : UIView

@property (nonatomic, weak) id<YGCTrimVideoControlViewDelegate> delegate;

@property (nonatomic, strong) UIColor *maskColor;

@property (nonatomic, assign) CGFloat mininumTimeWidth;


- (id)initWithFrame:(CGRect)frame
   leftControlImage:(UIImage *)leftImage
  rightControlImage:(UIImage *)rightImage
   centerRangeImage:(UIImage *)centerImage
       sideBarWidth:(CGFloat)sidebarWidth;

- (void)resetLeftSideBarImage:(UIImage *)leftImage;
- (void)resetRightSideBarImage:(UIImage *)rightImage;
- (void)resetCenterRangeImage:(UIImage *)centerRangeImage;
@end

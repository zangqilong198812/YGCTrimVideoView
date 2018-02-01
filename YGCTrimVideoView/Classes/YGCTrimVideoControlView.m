//
//  YGCTrimVideoControlView.m
//  VideoTrimView
//
//  Created by Qilong Zang on 30/01/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import "YGCTrimVideoControlView.h"
#import "UIView+YGCFrameUtil.h"

static const CGFloat kDefaultControlBarWidth = 10;

@interface YGCTrimVideoControlView()

@property (nonatomic, strong) UIImageView *leftControlBar;
@property (nonatomic, strong) UIImageView *rightControlBar;
@property (nonatomic, strong) UIImageView *centerRangeView;
@property (nonatomic, strong) UIImageView *centerAlphaRangeView;

@property (nonatomic, strong) UIView *leftMaskView;
@property (nonatomic, strong) UIView *rightMaskView;

@property (nonatomic, assign) CGFloat sidebarWidth;

@end

@implementation YGCTrimVideoControlView

- (id)initWithFrame:(CGRect)frame
   leftControlImage:(UIImage *)leftImage
  rightControlImage:(UIImage *)rightImage
   centerRangeImage:(UIImage *)centerImage
       sideBarWidth:(CGFloat)sidebarWidth
{
    if (self = [super initWithFrame:frame]) {
        NSAssert(sidebarWidth != 0, @"side bar width can not be 0");
        self.sidebarWidth = sidebarWidth;
        [self commonInit];

        if (!leftImage) {
            self.leftControlBar.image = [UIImage imageNamed:@"default_sidebar_image"];
        }else {
            self.leftControlBar.image = leftImage;
        }

        if (!rightImage) {
            self.rightControlBar.image = [UIImage imageNamed:@"default_sidebar_image"];
        }else {
            self.rightControlBar.image = rightImage;
        }

        if (!centerImage) {
            self.centerRangeView.image = [UIImage imageNamed:@"default_range_image"];
        }else {
            self.centerRangeView.image = centerImage;
        }

        self.centerAlphaRangeView.image = [UIImage imageNamed:@"transparent_bgimage"];

        self.maskColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return self;
}

#pragma mark - override hitTest

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(CGRectInset(self.leftControlBar.frame, -10, 0), point)) {
        return self.leftControlBar;
    }

    if (CGRectContainsPoint(CGRectInset(self.rightControlBar.frame, -10, 0), point)) {
        return self.rightControlBar;
    }

    return nil;
}

#pragma mark - Common Init

- (void)commonInit {
    self.leftControlBar.frame = CGRectMake(0, 0, self.sidebarWidth, self.ygc_height);
    self.rightControlBar.frame = CGRectMake(self.ygc_width - kDefaultControlBarWidth, 0, kDefaultControlBarWidth, self.ygc_height);
    self.centerRangeView.frame = CGRectMake(self.leftControlBar.ygc_minX, 0, self.rightControlBar.ygc_maxX - self.leftControlBar.ygc_minX, self.ygc_height);
    self.centerAlphaRangeView.frame = self.bounds;

    UIPanGestureRecognizer *leftControlPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftControlGesture:)];
    [self.leftControlBar addGestureRecognizer:leftControlPan];

    UIPanGestureRecognizer *rightControlPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightControlGesture:)];
    [self.rightControlBar addGestureRecognizer:rightControlPan];

    [self addSubview:self.leftMaskView];
    [self addSubview:self.rightMaskView];
    [self addSubview:self.centerAlphaRangeView];
    [self addSubview:self.centerRangeView];
    [self addSubview:self.leftControlBar];
    [self addSubview:self.rightControlBar];

}

#pragma mark - Gesture Handler

- (void)handleLeftControlGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat translateX = [gesture translationInView:self].x;
        CGFloat leftPositionX = self.leftControlBar.ygc_minX + translateX;
        CGFloat rightPositionX = self.rightControlBar.ygc_minX;

        if (leftPositionX < 0) {
            leftPositionX = 0;
        }

        CGFloat rangeLength = rightPositionX - leftPositionX - self.sidebarWidth;
        if (rangeLength <= self.mininumTimeWidth) {
            leftPositionX = leftPositionX - translateX;
        }

        [self.leftControlBar ygc_setMinX:leftPositionX];
        self.centerRangeView.frame = CGRectMake(self.leftControlBar.ygc_minX, 0, self.rightControlBar.ygc_maxX - self.leftControlBar.ygc_minX, self.ygc_height);
        self.leftMaskView.frame = CGRectMake(0, 0, self.leftControlBar.ygc_minX, self.ygc_height);
        self.rightMaskView.frame = CGRectMake(self.rightControlBar.ygc_maxX, 0, self.ygc_width - self.rightControlBar.ygc_maxX, self.ygc_height);
        [gesture setTranslation:CGPointZero inView:self];

        if ([self.delegate respondsToSelector:@selector(leftSideBarChangedFrame:rightBarCurrentFrame:)]) {
            [self.delegate leftSideBarChangedFrame:self.leftControlBar.frame rightBarCurrentFrame:self.rightControlBar.frame];
        }
    }else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if ([self.delegate respondsToSelector:@selector(panGestureEnded:rightFrame:)]) {
            [self.delegate panGestureEnded:self.leftControlBar.frame rightFrame:self.rightControlBar.frame];
        }
    }
}

- (void)handleRightControlGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat translateX = [gesture translationInView:self].x;
        CGFloat leftPositionX = self.leftControlBar.ygc_minX;
        CGFloat rightPositionX = self.rightControlBar.ygc_minX + translateX;

        if (rightPositionX + self.sidebarWidth > self.bounds.size.width) {
            rightPositionX -= translateX;
        }

        CGFloat rangeLength = rightPositionX - leftPositionX - self.sidebarWidth;
        if (rangeLength < self.mininumTimeWidth) {
            rightPositionX -= translateX;
        }

        [self.rightControlBar ygc_setMinX:rightPositionX];
        self.centerRangeView.frame = CGRectMake(self.leftControlBar.ygc_minX, 0, self.rightControlBar.ygc_maxX - self.leftControlBar.ygc_minX, self.ygc_height);
        self.leftMaskView.frame = CGRectMake(0, 0, self.leftControlBar.ygc_minX, self.ygc_height);
        self.rightMaskView.frame = CGRectMake(self.rightControlBar.ygc_maxX, 0, self.ygc_width - self.rightControlBar.ygc_maxX, self.ygc_height);
        [gesture setTranslation:CGPointZero inView:self];

        if ([self.delegate respondsToSelector:@selector(rightSideBarChangedFrame:leftBarCurrentFrame:)]) {
            [self.delegate rightSideBarChangedFrame:self.rightControlBar.frame leftBarCurrentFrame:self.leftControlBar.frame];
        }
    }else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if ([self.delegate respondsToSelector:@selector(panGestureEnded:rightFrame:)]) {
            [self.delegate panGestureEnded:self.leftControlBar.frame rightFrame:self.rightControlBar.frame];
        }
    }
}

#pragma mark - Getter

- (UIImageView *)leftControlBar {
    if (_leftControlBar == nil) {
        _leftControlBar = [[UIImageView alloc] init];
    }
    return _leftControlBar;
}

- (UIImageView *)rightControlBar {
    if (_rightControlBar == nil) {
        _rightControlBar = [[UIImageView alloc] init];
    }
    return _rightControlBar;
}

- (UIImageView *)centerRangeView {
    if (_centerRangeView == nil) {
        _centerRangeView = [[UIImageView alloc] init];
    }
    return _centerRangeView;
}

- (UIImageView *)centerAlphaRangeView {
    if (_centerAlphaRangeView == nil) {
        _centerAlphaRangeView = [[UIImageView alloc] init];
    }
    return _centerAlphaRangeView;
}

- (UIView *)leftMaskView {
    if (_leftMaskView == nil) {
        _leftMaskView = [[UIView alloc] init];
    }
    return _leftMaskView;
}

- (UIView *)rightMaskView {
    if (_rightMaskView == nil) {
        _rightMaskView = [[UIView alloc] init];
    }
    return _rightMaskView;
}

#pragma mark - Setter

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    self.leftMaskView.backgroundColor = _maskColor;
    self.rightMaskView.backgroundColor = _maskColor;
}

#pragma mark - Public Method
- (void)resetLeftSideBarImage:(UIImage *)leftImage {
    self.leftControlBar.image = leftImage;
}
- (void)resetRightSideBarImage:(UIImage *)rightImage {
    self.rightControlBar.image = rightImage;
}
- (void)resetCenterRangeImage:(UIImage *)centerRangeImage {
    self.centerRangeView.image = centerRangeImage;
}

@end

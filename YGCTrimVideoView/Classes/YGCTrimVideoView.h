//
//  YGCTrimVideoView.h
//  VideoTrimView
//
//  Created by Qilong Zang on 30/01/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGCTrimVideoView : UIView

@property (nonatomic, assign) CGFloat sidebarWidth;

@property (nonatomic, strong) UIImage *leftSidebarImage;

@property (nonatomic, strong) UIImage *rightSidebarImage;

@property (nonatomic, strong) UIImage *centerRangeImage;

@property (nonatomic, assign) NSTimeInterval maxSeconds;

@property (nonatomic, assign) NSTimeInterval minSeconds;

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

- (void)generateVideoThumb;

@end

//
//  YGCTrimVideoControlView.h
//  VideoTrimView
//
//  Created by Qilong Zang on 30/01/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGCTrimVideoControlView : UIView

@property (nonatomic, strong) UIColor *maskColor;

@property (nonatomic, assign) CGFloat mininumTimeWidth;


- (id)initWithFrame:(CGRect)frame
   leftControlImage:(UIImage *)leftImage
  rightControlImage:(UIImage *)rightImage
   centerRangeImage:(UIImage *)centerImage
       sideBarWidth:(CGFloat)sidebarWidth;

@end

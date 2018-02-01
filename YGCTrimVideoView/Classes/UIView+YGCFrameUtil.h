//
//  UIView+YGCFrameUtil.h
//  VideoTrimView
//
//  Created by Qilong Zang on 30/01/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YGCFrameUtil)

- (CGFloat)ygc_minX;
- (CGFloat)ygc_maxX;
- (CGFloat)ygc_width;
- (CGFloat)ygc_height;

- (void)ygc_setMinX:(CGFloat)minX;
- (void)ygc_setMaxX:(CGFloat)maxX;

@end

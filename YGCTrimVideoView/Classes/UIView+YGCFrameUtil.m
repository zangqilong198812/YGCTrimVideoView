//
//  UIView+YGCFrameUtil.m
//  VideoTrimView
//
//  Created by Qilong Zang on 30/01/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import "UIView+YGCFrameUtil.h"

@implementation UIView (YGCFrameUtil)

- (CGFloat)ygc_minX {
    return CGRectGetMinX(self.frame);
}
- (CGFloat)ygc_maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)ygc_width {
    return CGRectGetWidth(self.frame);
}
- (CGFloat)ygc_height {
    return CGRectGetHeight(self.frame);
}

- (void)ygc_setMinX:(CGFloat)minX {
    self.frame = CGRectMake(minX, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
- (void)ygc_setMaxX:(CGFloat)maxX {
    self.frame = CGRectMake(maxX - CGRectGetWidth(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

@end

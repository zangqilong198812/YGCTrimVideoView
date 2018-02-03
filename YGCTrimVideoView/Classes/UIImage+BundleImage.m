//
//  UIImage+BundleImage.m
//  YGCTrimVideoViewDemo
//
//  Created by Qilong Zang on 02/02/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import "UIImage+BundleImage.h"
#import "YGCTrimVideoView.h"

static NSString * const kResourceBundleName = @"defaultImage.bundle";

@implementation UIImage (BundleImage)

+ (NSBundle *)resourceBundle {
    NSBundle *bundle = [NSBundle bundleForClass:[YGCTrimVideoView class]];
    return bundle;
    
}

+ (UIImage *)bundleImage:(NSString *)name {
    NSString *pathName = [kResourceBundleName stringByAppendingPathComponent:name];
    return [UIImage imageNamed:pathName inBundle:[self resourceBundle] compatibleWithTraitCollection:nil];
}

@end


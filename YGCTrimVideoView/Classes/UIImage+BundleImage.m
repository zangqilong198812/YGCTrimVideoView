//
//  UIImage+BundleImage.m
//  YGCTrimVideoViewDemo
//
//  Created by Qilong Zang on 02/02/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import "UIImage+BundleImage.h"

static NSString * const kResourceBundleName = @"defaultImage.bundle";

@implementation UIImage (BundleImage)

+ (NSBundle *)resourceBundle {
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSURL *bundleURL = [[bundle resourceURL] URLByAppendingPathComponent:kResourceBundleName];
  NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
  return resourceBundle;
}

+ (UIImage *)bundleImage:(NSString *)name {

  return [UIImage imageNamed:name inBundle:[UIImage resourceBundle] compatibleWithTraitCollection:nil];
}

@end

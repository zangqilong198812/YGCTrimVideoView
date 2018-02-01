//
//  YGCThumbCollectionViewCell.m
//  VideoTrimView
//
//  Created by Qilong Zang on 30/01/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import "YGCThumbCollectionViewCell.h"

@implementation YGCThumbCollectionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }

    return self;
}

- (void)commonInit {
    [self.contentView addSubview:self.thumbImageView];
    [NSLayoutConstraint activateConstraints:@[[self.thumbImageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
                                              [self.thumbImageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor],
                                              [self.thumbImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
                                              [self.thumbImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor]]];
}

#pragma mark - Getter

- (UIImageView *)thumbImageView {
    if (_thumbImageView == nil) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
        _thumbImageView.clipsToBounds = YES;
        _thumbImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _thumbImageView;
}

@end

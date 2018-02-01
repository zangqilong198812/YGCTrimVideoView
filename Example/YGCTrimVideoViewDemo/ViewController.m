//
//  ViewController.m
//  YGCTrimVideoViewDemo
//
//  Created by Qilong Zang on 01/02/2018.
//  Copyright © 2018 Qilong Zang. All rights reserved.
//

#import "ViewController.h"
#import "YGCTrimVideoView.h"

@interface ViewController ()
@property (nonatomic, strong) YGCTrimVideoView *ygcTrimView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zuxian"
                                                     ofType:@"MP4"];
    self.ygcTrimView = [[YGCTrimVideoView alloc] initWithFrame:CGRectMake(0, 75, self.view.bounds.size.width, 80)
                                                       assetUR:[NSURL fileURLWithPath:path]];
    [self.view addSubview:self.ygcTrimView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

<div align = "center">
<img src="https://ws1.sinaimg.cn/large/006tNc79ly1fo0zzmjr5mj30jg05kq4a.jpg" width="700" />
</div>

<p align="center">
<img src="https://img.shields.io/badge/ObjC-2.0-orange.svg" alt="Objective-C"/>
<img src="https://img.shields.io/badge/platform-iOS-brightgreen.svg" alt="Platform: iOS"/>
<img src="https://img.shields.io/badge/Xcode-9%2B-brightgreen.svg" alt="XCode 9+"/>
<img src="https://img.shields.io/badge/iOS-11%2B-brightgreen.svg" alt="iOS 11"/>
<img src="https://img.shields.io/badge/licence-MIT-lightgray.svg" alt="Licence MIT"/>
</a>
</p>

# YGCTrimVideoView

A wechat like video trim time view.



### Features
- [x] left and right time control
- [x] custom your left side bar and right
- [x] support setup maximum duration and minimum duration


## Looks like
![](https://ws2.sinaimg.cn/large/006tNc79ly1fo15brtdgkg30cz0p8qv6.gif)
## Usage
### Initialize

```  
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoName"
                                                     ofType:@"MP4"];
    YGCTrimVideoView *ygcTrimView = [[YGCTrimVideoView alloc] initWithFrame:CGRectMake(0, 75, self.view.bounds.size.width, 80)
                                                       assetUR:[NSURL fileURLWithPath:path]];
    [self.view addSubview:self.ygcTrimView];
```
That's all




## Installing

#### Cocoapods
`pod 'YGCTrimVideoView'`  

 please use version 0.2.0

## Requirements

* iOS 10 or higher

## Authors

* **zang qilong** -  [zangqilong](https://github.com/zangqilong198812)

## Communication

* If you **found a bug**, open an issue.
* If you **have a feature request**, open an issue.
* If you **want to contribute**, submit a pull request.

## License

This project is licensed under the MIT License.



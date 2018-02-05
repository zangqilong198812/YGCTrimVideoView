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
- [x] export video file from your time crop setting


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

### Make custom UI

```
- (id)initWithFrame:(CGRect)frame
   leftControlImage:(UIImage *)leftImage
  rightControlImage:(UIImage *)rightImage
   centerRangeImage:(UIImage *)centerImage
       sideBarWidth:(CGFloat)sidebarWidth;
```

* `leftImage` you could setup your left sidebar with a image
* `rightImage` same as leftImage
* `centerRangeImage` the border image around the slider, maybe required set the image's resize inset
* `sideBarWidth` the control bar width

### Setup maximum duration and minimum duration
just setup the property `maxSeconds` and `minSeconds`.

``` 
// min duration is 2 and max duration is 10 
self.ygcTrimView.minSeconds = 2;
self.ygcTrimView.maxSeconds = 10;
```

### Preview the cropped video

in the delegate funtion 


```
- (void)dragActionEnded:(AVMutableComposition *)asset
```

every time your finished dragging the control bar
YGCTrimView will generate a AVMutableCompsition.You could create a AVPlayer and play the composition directly.
like

```  
- (void)dragActionEnded:(AVMutableComposition *)asset {
  self.playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
  [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
  [self.player play];

}
```

### Export Video
YGCTrimVideoView support two ways to export a video file.
**First Method**

```  
- (void)dragActionEnded:(AVMutableComposition *)asset;
```

get a AVMutableComposition from the delegate function. An AVMutableComposition is an AVAsset.So you could use AVExportSession to export a video file from AVMutableComposition.

**Second Method**

```
- (void)exportVideo:(YGCExportFinished)finishedBlock;
```
you could use the function directly to export a video file .The finishedBlock will give you the video url that from the sandbox.

## Installing

#### Cocoapods
In your podfile.
`pod 'YGCTrimVideoView', '~> 0.2.2' ` 
then `pod install`
if you get an error " Unable to satisfy the following requirements", please use 
`pod install --repo-update`

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



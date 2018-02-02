#
# Be sure to run `pod lib lint YGCTrimVideoView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YGCTrimVideoView'
  s.version          = '0.1.9'
  s.summary          = 'A wechat like video editor view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        A wechat like video editor view. You could setup the maximum duration of a video and the minimum duration of a video.
                        Also include the function of custom your time slider view.
                       DESC

  s.homepage         = 'https://github.com/zangqilong198812/YGCTrimVideoView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zangqilong' => 'zangqilong@gmail.com' }
  s.source           = { :git => 'https://github.com/zangqilong198812/YGCTrimVideoView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'YGCTrimVideoView/Classes/*.{h,m,c}'
  
  s.resource_bundles = {
    'YGCTrimVideoView' => ['YGCTrimVideoView/Assets/*.xcassets']
  }

  s.public_header_files = 'YGCTrimVideoView/Classes/*.h'
  s.frameworks = 'AVFoundation'
end

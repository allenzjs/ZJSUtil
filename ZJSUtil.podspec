#
# Be sure to run `pod lib lint ZJSUtil.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZJSUtil'
  s.version          = '0.2.0'
  s.summary          = 'a convenient util kit for ios project.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'a convenient util kit for ios project, macro, category.'

  s.homepage         = 'https://github.com/allenzjs/ZJSUtil'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'allenzjs' => 'qianchang123987@163.com' }
  s.source           = { :git => 'https://github.com/allenzjs/ZJSUtil.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  
  s.source_files = 'ZJSUtil/Classes/*'
  
  s.prefix_header_contents = '#import "ZJSUtil-PrefixHeader.h"'
  
  # s.resource_bundles = {
  #   'ZJSUtil' => ['ZJSUtil/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.subspec 'Util' do |ss|
      ss.public_header_files = 'Pod/Classes/Util/**/*.h'
      ss.source_files = 'ZJSUtil/Classes/Util/**/*'
  end
  
  s.subspec 'Categories' do |ss|
      ss.public_header_files = 'Pod/Classes/Categories/**/*.h'
      ss.source_files = 'ZJSUtil/Classes/Categories/**/*'
  end
  
end

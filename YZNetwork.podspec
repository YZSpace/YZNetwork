#
# Be sure to run `pod lib lint YZNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YZNetwork'
  s.version          = '0.1.0'
  s.summary          = 'YZNetwork是基于AFNetworking~>3.2封装的iOS端简易网络库，通过创建请求对象的方式处理网络接口.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
YZNetwork是基于AFNetworking~>3.2封装的iOS端简易网络库，通过创建请求对象的方式处理网络接口.
                       DESC

  s.homepage         = 'https://github.com/zone1026/YZNetwork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zone1026' => '1024105345@qq.com' }
  s.source           = { :git => 'https://github.com/zone1026/YZNetwork.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YZNetwork/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YZNetwork' => ['YZNetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 3.2'
end

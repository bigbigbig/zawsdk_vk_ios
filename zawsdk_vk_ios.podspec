#
# Be sure to run `pod lib lint zawsdk_vk_ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'zawsdk_vk_ios'
  s.version          = '0.0.1'
  s.summary          = 'zawsdk vk part for ios'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/bigbigbig/zawsdk_vk_ios.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bigbigbig' => '1046724509@qq.com' }
  s.source           = { :git => 'https://github.com/bigbigbig/zawsdk_vk_ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios, '13.0'
  s.ios.deployment_target = '13.0'

  s.source_files = 'zawsdk_vk_ios/Classes/**/*'
  
  s.swift_versions = ['5.0']
  
  s.static_framework = true
  s.public_header_files = 'zawsdk_vk_ios/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'VKID', '2.7.0'

  # s.resource_bundles = {
  #   'zawsdk_vk_ios' => ['zawsdk_vk_ios/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

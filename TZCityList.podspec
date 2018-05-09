#
# Be sure to run `pod lib lint TZCityList.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TZCityList'
  s.version          = '0.0.1'
  s.summary          = '进行地理位置的选择'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
该库实现地理位置选择的功能，例如京东收货地址选择
                       DESC
  s.homepage         = 'https://github.com/TuZhen/TZCityList'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TuZhen' => '13926437204@163.com' }
  s.source           = { :git => 'https://github.com/TuZhen/TZCityList.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

s.source_files = 'TZCityList/Classes/*.{h,m,xib}'
  s.dependency 'FMDB'
#s.resources = ["Image/*.png", "Files/*"]
s.resource_bundles = {
'TZCityList' => ['TZCityList/Image/*.png'，]
#'TZCityList' => ['TZCityList/Files/City.db']

}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

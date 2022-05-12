#
# Be sure to run `pod lib lint iOSCTLibKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iOSCTLibKit'
  s.version          = '0.1.0'
  s.summary          = 'A demo lib of Cocoapod.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/iRobin520/iOSCTLibKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Robin Shen' => 'shenlubing2002@163.com' }
  s.source           = { :git => 'https://github.com/iRobin520/iOSCTLibKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.subspec 'iOSCTLibKit' do |tt|
    tt.dependency 'RxSwift'
    tt.dependency 'Alamofire'
  end

  s.source_files = 'iOSCTLibKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'iOSCTLibKit' => ['iOSCTLibKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

#
# Be sure to run `pod lib lint AnnotationTextIOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AnnotationTextIOS'
  s.version          = '0.1.0'
  s.summary          = 'An Library to show textview which can config annotation in Japanese&Chinese'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  In Japanese, the text may have katakana
  In Chinese, the text may have PinYin which we call
  This Library Will help your textview to show This Japanese&Chinese
                       DESC

  s.homepage         = 'https://github.com/zamberform/AnnotationTextIOS'
  s.screenshots     = 'https://github.com/zamberform/AnnotationTextIOS/tree/master/screenshots/sample0.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zamberform' => 'brightzamber@gmail.com' }
  s.source           = { :git => 'https://github.com/zamberform/AnnotationTextIOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '5.0'
  s.source_files = 'AnnotationTextIOS/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AnnotationTextIOS' => ['AnnotationTextIOS/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

#
# Be sure to run `pod lib lint IOS_SDK_PAYU.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IOS_SDK_PAYU'
  s.version          = '0.0.1'
  s.summary          = 'Апи для работы с платежным сервисом PAYU'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/payuru/IOS_SDK_PAYU'
  s.screenshots     = 'http://i.imgur.com/UDHGr6v.png', 'http://i.imgur.com/uiYZ8a1.png','http://i.imgur.com/vxXdOAK.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Maxim Melikhov' => 'ixotdog@gmail.com' }
  s.source           = { :git => 'https://github.com/payuru/IOS_SDK_PAYU.git', :tag => s.version.to_s }
  s.social_media_url = 'https://ipolh.com'

  s.ios.deployment_target = '8.0'

  s.source_files = 'IOS_SDK_PAYU/Classes/**/*'
  
  # s.resource_bundles = {
  #   'IOS_SDK_PAYU' => ['IOS_SDK_PAYU/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'MBProgressHUD'
    s.dependency 'XMLDictionary', '~> 1.4'
end

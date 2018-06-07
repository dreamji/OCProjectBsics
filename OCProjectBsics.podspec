#
# Be sure to run `pod lib lint OCProjectBsics.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OCProjectBsics'
  s.version          = '0.1.9'
  s.summary          = 'A short description of OCProjectBsics.'
  s.homepage         = 'https://github.com/AsTao/OCProjectBsics'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tobias' => '236048180@qq.com' }
  s.source           = { :git => 'https://github.com/AsTao/OCProjectBsics.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.resources = 'OCProjectBsics/OCResource.bundle'
  s.source_files = 'OCProjectBsics/**/*.{h,m}'
  s.public_header_files = 'OCProjectBsics/OCProjectBsics.h', 'OCProjectBsics/Base/*.h', 'OCProjectBsics/Common/*.h', 'OCProjectBsics/Http/*.h'
  # s.resource_bundles = {
  #   'OCProjectBsics' => ['OCProjectBsics/Assets/*.png']
  # }

  
   s.frameworks = 'UIKit', 'Foundation' , 'CoreGraphics'
   s.dependency 'SAMKeychain'
   s.dependency 'AFNetworking', '~> 3.0'
   s.dependency 'MJRefresh', '~> 3.1.10'
   s.dependency 'YYModel'
   s.dependency 'DGActivityIndicatorView'

end

#
# Be sure to run `pod lib lint ANShareViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ANShareViewController"
  s.version          = "0.1.0"
  s.summary          = "Airbnb sharing controller."
  s.description      = <<-DESC
                            ANShareViewController is a Sharing View Controller that allows us to share links via facebook, email, sms or copy it to buffer.
                       DESC

  s.homepage         = "https://github.com/antrix1989/ANShareViewController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Sergey Demchenko" => "antrix1989@gmail.com" }
  s.source           = { :git => "https://github.com/antrix1989/ANShareViewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/SergeyDemchenko'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ANShareViewController' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MessageUI'
  s.dependency 'FBSDKShareKit', '~> 4.1.0', 'FBSDKCoreKit', '~> 4.2.0'
end

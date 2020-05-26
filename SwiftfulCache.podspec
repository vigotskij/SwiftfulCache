#
# Be sure to run `pod lib lint SwiftfulCache.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftfulCache'
  s.version          = '0.1.0'
  s.summary          = 'Swift wrapper for NSCache'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'Swift volatile and persistent cache. It allows your app to use NSCache only using pure Swift.'
                       DESC

  s.homepage         = 'https://github.com/vigotskij/SwiftfulCache'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Boris Sortino' => 'boris.sortino@gmail.com' }
  s.source           = { :git => 'https://github.com/vigotskij/SwiftfulCache.git', :tag => s.version.to_s }
  s.social_media_url = 'https://linkedin.com/in/bsortino/'
  s.requires_arc = true
  s.ios.deployment_target = '13.0'

  s.source_files = 'SwiftfulCache/**/*.swift'
  s.swift_version = "5.2"
  s.platforms = {
      "ios" => "13.0"
  }
  
  # s.resource_bundles = {
  #   'SwiftfulCache' => ['SwiftfulCache/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

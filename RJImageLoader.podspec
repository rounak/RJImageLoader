#
# Be sure to run `pod lib lint RJImageLoader.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RJImageLoader"
  s.version          = "0.2.0"
  s.summary          = "A neat image loader for iOS based on Michael Villar's design."
  s.description      = <<-DESC
                       RJImageLoader is a category on UIImageView that lets you add a circular progress and reveal animation when loading images from the network. It is agnostic to the image download process, has a simple interface, and is very easy to integrate.
                       DESC
  s.homepage         = "https://github.com/rounak/RJImageLoader"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Rounak" => "rounak91@gmail.com" }
  s.source           = { :git => "https://github.com/rounak/RJImageLoader.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/r0unak'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'RJImageLoader' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

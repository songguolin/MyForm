#
#  Be sure to run `pod spec lint MyForm.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "MyForm"
  s.version      = "0.0.2"
  s.summary      = "An easy way to table"
  s.homepage     = "https://github.com/songguolin/MyForm"
  s.license      = "MIT"
  s.author             = { "guolin     song" => "1119164930@qq.com" }
  s.source       = { :git => "https://github.com/songguolin/MyForm.git", :tag => "#{s.version}" }
  s.source_files  = "MyForm/**/*.{h,m}"
  s.requires_arc = true
  s.ios.deployment_target = '7.0'


# s.dependency "YYWebImage", "~> 1.0.5"
  s.dependency "Masonry"


end

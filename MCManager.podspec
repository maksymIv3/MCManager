Pod::Spec.new do |spec|

  spec.platform = :ios
  spec.ios.deployment_target = '12.0'

  spec.name         = "MCManager"
  spec.version      = "0.0.8"
  spec.summary      = "A CocoaPods library written in Objective-c"

  spec.description  = <<-DESC
This CocoaPods library helps you perform managing multipeer connectivity.
                   DESC

  spec.homepage     = "https://github.com/maksymIv3/MCManager"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Maksym Ivanyk" => "maksym.ivanyk@rolique.io" }

  spec.source        = { :git => "https://github.com/maksymIv3/MCManager.git", :tag => "#{spec.version}" }
  spec.source_files  = "MCManager/**/*.{h,m}"
end

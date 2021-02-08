Pod::Spec.new do |spec|

  spec.name         = "RCNativeiOSSDK"
  spec.version      = "0.0.13"
  spec.summary      = "A CocoaPods library written in Swift for Revcontent."

  spec.description  = <<-DESC
A CocoaPods library written in Swift for the Revcontent to enables you to receive the same ad fill you would see in our traditional ad placements in a more flexible format.
                   DESC

  spec.homepage     = "https://github.com/RevContent/RCNativeiOSSDK.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Chris" => "chris@revcontent.com" }

  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"

  spec.source        = { :git => "https://github.com/RevContent/RCNativeiOSSDK.git", :tag => "#{spec.version}" }
  spec.source_files  = "RCNativeiOSSDK/**/*.{h,m,swift}"
  spec.resource_bundles = {
    'RCNativeiOSSDK' => ['RCNativeiOSSDK/Assets/**/*']
  }

end

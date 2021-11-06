Pod::Spec.new do |s|

  s.name                  = 'goTapAPIV2'
  s.version               = '1.0.1'
  s.summary               = 'goTapAPI'
  s.description           = 'API Client for goTap'
  s.homepage              = 'https://github.com/Tap-Payments/goTapAPI_iOSV2'
  s.author                = { 'Osama Rabie' => 'o.rabie@tap.company' }
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.platform              = :ios
  s.swift_version         = '4.1'
  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
  s.requires_arc          = true
  s.source                = { :git => 'https://github.com/Tap-Payments/goTapAPI_iOSV2.git', :tag => s.version.to_s }
  s.source_files          = 'goTapAPI/**/*.{swift}', 'Frameworks/**/*'
  s.exclude_files         = 'goTapAPI/goTapAPI/*'
  
  s.dependency 'SDWebImage'
  s.dependency 'TapAdditionsKitV2'
  s.dependency 'TapNetworkManagerV2'
  s.dependency 'TapSwiftFixesV2'

end

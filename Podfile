platform :ios, '10.0'
use_frameworks!


target 'goTapAPI' do
    
    pod 'SDWebImage'
    pod 'TapAdditionsKitV2'
    pod 'TapNetworkManagerV2'
    pod 'TapSwiftFixesV2'
    
end

post_install do |installer|
    
    installer.pods_project.targets.each do |target|
        
        target.build_configurations.each do |config|
            
            config.build_settings['SWIFT_VERSION'] = '4.1'

        end
    end
    
end

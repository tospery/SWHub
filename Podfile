source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

target 'SWHub' do

  pod 'SWFrame', :path => '../SWFrame'
  # pod 'SWFrame', '1.3.8'

  pod 'DefaultsKit', '0.2.0'
  pod 'Cache', '6.0.0'
  pod 'SwiftEntryKit', '1.2.6'
  pod 'IQKeyboardManagerSwift', '6.5.6'
  pod 'ReusableKit/RxSwift', '3.0.0'
  pod 'Toast-Swift', '5.0.1'
  pod 'R.swift', '5.3.0'
  pod 'SwiftLint', '0.41.0'
  pod 'Umbrella/Core', '0.9.0'
  pod 'Parchment', '3.0.0'
  pod 'SnapKit', '5.0.1'
  pod 'DateToolsSwift', '5.0.0'
  
  pod 'UMCommon', '7.2.8'
  pod 'UMDevice', '1.2.0'
  pod 'UMShare/UI', '6.10.2'
  pod 'UMShare/Social/WeChat', '6.10.2'
  
  # pod 'TTTAttributedLabel', '2.0.0'
  
  pod 'MLeaksFinder', '1.0.0'
  # pod 'FLEX', '3.0.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
    end
end

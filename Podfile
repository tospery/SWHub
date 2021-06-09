source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

target 'SWHub' do

  # pod 'SWFrame', :path => '../SWFrame'
  pod 'SWFrame', '1.4.1'

  pod 'RxOptional', '4.1.0'
  pod 'RxSwiftExt', '5.2.0'
  pod 'RxGesture', '3.0.2'
  pod 'RxViewController', '1.0.0'
  pod 'Cache', '6.0.0'
  pod 'IQKeyboardManagerSwift', '6.5.6'
  pod 'ReusableKit/RxSwift', '3.0.0'
  pod 'Toast-Swift', '5.0.1'
  pod 'R.swift', '5.3.0'
  pod 'SwiftLint', '0.41.0'
  pod 'Parchment', '3.0.0'
  pod 'SnapKit', '5.0.1'
  pod 'AcknowList', '2.0.1'
  pod 'DateToolsSwift-JX', '5.0.0-jx3'
  pod 'UMCommon', '7.2.8'
  pod 'UMDevice', '1.2.0'
  pod 'Highlightr', '2.1.0'
  pod 'MarkdownView', '1.5.0'
  pod 'TTGTagCollectionView', '2.0.1'
  pod 'SideMenu', '6.5.0'
  pod 'PopupDialog', '1.1.1'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
    end
end

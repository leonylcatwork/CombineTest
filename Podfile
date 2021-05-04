source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '14.1'

use_frameworks!
inhibit_all_warnings!

def import_pods
  pod 'RxSwift', '6.1.0'
  pod 'RxCocoa', '6.1.0'
end

target 'CombineTest' do
  import_pods
  target 'CombineTestTests' do
    inherit! :search_paths
  end
end

# remove pod specific ios deployment target
# so that all pods use default ios deployment taget
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

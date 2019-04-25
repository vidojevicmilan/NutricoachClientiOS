# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Nutricoach' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Nutricoach

pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'SVProgressHUD'
pod 'ChameleonFramework'
pod 'MessageKit'
pod 'BulletinBoard'

  target 'NutricoachTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NutricoachUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
        end
    end
end

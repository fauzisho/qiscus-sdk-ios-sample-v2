# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'qiscus-sdk-ios-sample-v2' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for qiscus-sdk-ios-sample-v2
  pod 'Qiscus', :git => 'https://github.com/qiscus/qiscus-sdk-ios.git', :branch => 'develop'
  pod 'PKHUD', '~> 4.0'
  pod 'BadgeSwift', '~> 4.0'
  pod 'IQKeyboardManagerSwift'
  
  target 'qiscus-sdk-ios-sample-v2Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'qiscus-sdk-ios-sample-v2UITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
workspace 'PhoneHealth.xcworkspace'
target 'PhoneHealth' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'IQKeyboardManagerSwift'
  pod 'SwiftyJSON'
  pod 'Alamofire'
  pod 'ObjectMapper'
  
  pod 'MaterialComponents/TextControls+OutlinedTextFields'
  pod 'KAPinField'
  pod 'MBRadioCheckboxButton'
  pod 'WeScan', '>= 0.9'
  pod 'FSCalendar'
  pod 'MBProgressHUD'
  pod 'lottie-ios'
  pod 'OnboardKit'
  pod 'Firebase/Analytics'
  
  pod 'SwiftyUserDefaults', '~> 4.0'
  pod 'SwiftyDrop'
  pod 'SwipeCellKit'
  pod 'ActiveLabel'
  pod 'JTAppleCalendar'
  pod 'SkeletonView'
  pod 'SDWebImage', :modular_headers => true
  pod 'NepaliDateConverter'

  # For Analytics without IDFA collection capability, use this pod instead
  # pod ‘Firebase/AnalyticsWithoutAdIdSupport’

  # Add the pods for any other Firebase products you want to use in your app
  # For example, to use Firebase Authentication and Cloud Firestore
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
end
#
#  target 'CogentIOSFramework' do
  
  target 'CogentIOSFramework' do
      use_frameworks!
      project '/Users/macbookpro/Downloads/CogentIOSFramework/CogentIOSFramework.xcodeproj'
      pod 'SwiftyJSON'
      pod 'SkeletonView'
      pod 'JTAppleCalendar'
      pod 'ActiveLabel'
      pod 'Alamofire'
      pod 'SwiftyUserDefaults', '~> 4.0'
      pod 'SwiftyDrop'
      pod 'SDWebImage', :modular_headers => true
      pod 'NepaliDateConverter'
end
# 'ActiveLabel', 'NepaliDateConverter', 'SwiftyDrop'
  
  
  target 'PhoneHealthTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PhoneHealthUITests' do
    # Pods for testing
  end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.name == "Debug"
        config.build_settings["SWIFT_OPTIMIZATION_LEVEL"] = "-Onone"
      end
    end
  end
end

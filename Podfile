source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'

def shared_pods
    pod 'Alamofire'
    pod 'Reusable'
end

target 'Currency' do
	shared_pods
end

target 'Tests' do
	shared_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
    	config.build_settings.delete('ARCHS')
    	config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end

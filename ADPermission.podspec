Pod::Spec.new do |s|

	s.name         = "ADPermission"
	s.version      = "0.0.2"
	s.summary      = "iOS权限请求，包含蓝牙，通讯录，定位，麦克风，日历，提醒，照相机，Siri，多媒体，相册，通知，语音识别，运动健康"
	s.description  = <<-DESC
	                 iOS权限请求，包含蓝牙，通讯录，定位，麦克风，日历，提醒，照相机，Siri，多媒体，相册，通知，语音识别，运动健康
	                 DESC
	s.homepage     = "https://github.com/tiancanfei/ADPermission"
	# 私有库可以不添加下面两项
	s.license      = { :type => "MIT", :file => "LICENSE" }
	s.author             = { "安德航" => "bjwltiankong@163.com" }
	#支持平台
	s.platform     = :ios
	#支持平台版本
	s.platform     = :ios, "10.0"
	#仓库地址 (不要使用ssh)
	s.source       = { :git => "https://github.com/tiancanfei/ADPermission.git", :tag => "#{s.version}" }
	#源文件位置 
	s.source_files = 'ADPermission/ADPermission/*.{h,m}'
	s.public_header_files = 'ADPermission/ADPermission/*.h'

	s.requires_arc = true

end

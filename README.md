# ADPermission
iOS权限请求，包含蓝牙，通讯录，定位，麦克风，日历，提醒，照相机，Siri，多媒体，相册，通知，语音识别，运动健康

### 1、如果用到ADPermission请设置条件编译宏，具体操作是在Podfile文件最后面添加如下hook语法

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'ADPermission'
      target.build_configurations.each do |config|
        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
        # 下面是例子（用到哪个添加哪个）：
        # 添加宏定义 CYDEMO 值是1（例子不必理会）
        # config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'CYDEMO=1'
        # 添加联系人权限询问
        # config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'ADPERMISSION_CONTACT'
        # 添加定位权限询问
        # config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'ADPERMISSION_LOCATION'
      end
    end
  end
end
```



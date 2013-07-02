node.default['android_sdk']['formula'] = 'android-sdk'
node.default['android_sdk']['haxm_dmg_path'] = 'extras/intel/Hardware_Accelerated_Execution_Manager/IntelHAXM.dmg'
node.default['android_sdk']['haxm_package'] = 'IntelHAXM_1.0.6'

node.default['android_sdk']['update_sdk_packages'] = false # requires user interaction
node.default['android_sdk']['install_haxm'] = false # requires user interaction

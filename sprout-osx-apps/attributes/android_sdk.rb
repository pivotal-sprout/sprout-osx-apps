node.default['android_sdk']['formula'] = 'android-sdk'

node.default['android_sdk']['update_sdk_packages'] = false # requires user interaction

node.default['android_sdk']['install_haxm'] = false # requires user interaction
node.default['android_sdk']['haxm_dmg_path'] = 'extras/intel/Hardware_Accelerated_Execution_Manager/IntelHAXM.dmg'
node.default['android_sdk']['haxm_package_name'] = 'IntelHAXM_1.0.6'
node.default['android_sdk']['haxm_package_id'] = 'com.intel.kext.haxm.1.0.6'
node.default['android_sdk']['haxm_checksum'] = 'd5b074070e0525af368a337c4b15f8896c3e66c5ad2b819e9eaa012b34717666'

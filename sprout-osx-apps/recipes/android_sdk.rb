return unless node['platform'] == 'mac_os_x'

user = node['current_user']

config = node['android_sdk']
formula = config['formula']

brew formula

sdk_root = `brew --prefix #{formula}`.strip

if config['update_sdk_packages']
  execute "update Android SDK packages" do
    command 'android update sdk --no-ui'
    user user
  end
end

if config['install_haxm']
  execute "update HAXM package" do
    command 'android update sdk --no-ui --filter extra-intel-Hardware_Accelerated_Execution_Manager'
    user user
  end

  haxm_pkg = config['haxm_package_name']

  # Symlink to cache dir so dmg_package can load the file
  link "#{Chef::Config[:file_cache_path]}/#{haxm_pkg}.dmg" do
    to "#{sdk_root}/#{config['haxm_dmg_path']}"
  end

  dmg_package haxm_pkg do
    owner user
    type "mpkg"
    not_if "kextstat | grep 'com.intel.kext.intelhaxm'"
  end
end

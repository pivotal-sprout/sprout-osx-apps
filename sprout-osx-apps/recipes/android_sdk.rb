return unless node['platform'] == 'mac_os_x'

user = node['current_user']

config = node['android_sdk']
formula = config['formula']
haxm_pkg = config['haxm_package_name']

brew formula

sdk_root = `brew --prefix #{formula}`.strip

execute 'update-sdk' do
  command 'android update sdk --no-ui'
  user user
  only_if { config['update_sdk_packages'] }
end

if config['install_haxm']
  execute 'update-haxm-pkg' do
    command 'android update sdk --no-ui --filter extra-intel-Hardware_Accelerated_Execution_Manager'
    user user
  end

  # Symlink to cache dir so dmg_package can load the file
  link "#{Chef::Config[:file_cache_path]}/#{haxm_pkg}.dmg" do
    to "#{sdk_root}/#{config['haxm_dmg_path']}"
  end

  dmg_package haxm_pkg do
    source 'http://example.com/' # Hack to keep dmg_package happy. Will not download.
    owner user
    type 'mpkg'
    package_id config['haxm_package_id']
    checksum config['haxm_checksum']
  end
end

user = node['current_user']

config = node['android_sdk']
formula = config['formula']
haxm_pkg = config['haxm_package_name']

package formula

sprout_osx_base_bash_it_custom_plugin 'bash_it/custom/android_home.bash'

execute 'update-sdk' do
  command 'echo y | android update sdk --no-ui --filter build-tools-19.0.0,platform-tools,android-18,android-19,addon-google_apis-google-18,addon-google_apis-google-19,sysimg-18,sysimg-19'
  user user
end

execute 'update-haxm-pkg' do
  command 'echo y | android update sdk --no-ui --filter extra-intel-Hardware_Accelerated_Execution_Manager'
  user user
end

# Symlink to cache dir so dmg_package can load the file
link "#{Chef::Config[:file_cache_path]}/#{haxm_pkg}.dmg" do
  to "#{`brew --prefix #{formula}`.strip}/#{config['haxm_dmg_path']}"
end

dmg_package haxm_pkg do
  source 'http://example.com/' # Hack to keep dmg_package happy. Will not download.
  owner user
  type 'mpkg'
  package_id config['haxm_package_id']
  checksum config['haxm_checksum']
end
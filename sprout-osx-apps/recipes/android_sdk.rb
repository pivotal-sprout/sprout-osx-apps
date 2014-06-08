user = node['current_user']

config = node['android_sdk']
formula = config['formula']
haxm_pkg = config['haxm_package_name']

package formula

sprout_base_bash_it_custom_plugin 'bash_it/custom/android_home.bash'

execute 'update-sdk-system-tools-and-platforms' do
  command 'echo y | android update sdk --no-ui --filter build-tools-19.0.3,platform-tools,android-19,addon-google_apis-google-19,extra-android-m2repository,extra-android-support'
end

execute 'update-sdk-system-images' do
  atom_system_image_package_id = 44
  # 44 is currently the package ID for the Intel Atom system image for SDK level 19. If we use 'sysimg-19' it will
  # try to install both system images, which causes 2 license challenges, which I don't know how to handle yet.

  # These package IDs are not permanent. They can change whenever the list of packages - stored on Google's servers - change.
  # Meaning this recipe is not very robust. A solution would be to parse the results of 'android list sdk --all' and find the
  # ID for the Intel Atom image.
  command "echo y | android update sdk -a --no-ui --filter #{atom_system_image_package_id}"
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

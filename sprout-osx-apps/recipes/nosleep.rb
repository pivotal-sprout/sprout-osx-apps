dmg_properties = node['sprout']['nosleep']['dmg']

dmg_package "NoSleep" do
  volumes_dir dmg_properties['volumes_dir']
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  package_id 'com.protech.pkg.NoSleep*' # Optional command line utils: com.protech.pkg.NoSleepCtrl
  type 'mpkg'
  owner node['current_user']
end

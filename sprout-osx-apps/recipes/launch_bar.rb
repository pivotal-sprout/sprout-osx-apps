dmg_properties = node['sprout']['launch_bar']['dmg']

dmg_package "LaunchBar" do
  volumes_dir dmg_properties['volumes_dir']
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  action :install
  owner node['current_user']
  accept_eula true
end

dmg_properties = node['sprout']['adium']['dmg']

dmg_package "Adium" do
  volumes_dir dmg_properties['volumes_dir']
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  action :install
  owner node['current_user']
end

dmg_properties = node['sprout']['handbrake']['dmg']

dmg_package "HandBrake" do
  volumes_dir dmg_properties['volumes_dir']
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  type        dmg_properties['type']
  action :install
  owner node['current_user']
end

dmg_properties = node['sprout']['parallels']['dmg']

dmg_package 'Parallels Desktop' do
  dmg_name    dmg_properties['dmg_name']
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  volumes_dir node['sprout']['parallels']['volumes_dir']

  action :install
  owner node['current_user']
end

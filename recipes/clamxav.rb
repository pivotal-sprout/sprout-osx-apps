dmg_package 'ClamXav' do
  dmg_properties = node['sprout']['clamxav']['dmg']
  action :install
  checksum dmg_properties['checksum']
  owner node['current_user']
  source dmg_properties['source']
  volumes_dir dmg_properties['volumes_dir']
end

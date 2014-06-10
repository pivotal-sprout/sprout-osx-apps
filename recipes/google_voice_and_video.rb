dmg_properties = node['sprout']['google_voice_and_video']['dmg']

dmg_package 'Google Voice and Video' do
  source dmg_properties['source']
  checksum dmg_properties['checksum']
  type 'pkg'
  package_id dmg_properties['package_id']
  volumes_dir dmg_properties['volumes_dir']
  action :install
  owner node['current_user']
end

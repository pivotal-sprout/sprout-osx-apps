dmg_properties = node['sprout']['royaltsx']['dmg']

dmg_package 'Royal TSX' do
  volumes_dir 'Royal TSX'
  source dmg_properties['source']
  checksum dmg_properties['checksum']
  accept_eula true
  action :install
  owner node['current_user']
end

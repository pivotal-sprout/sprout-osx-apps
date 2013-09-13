dmg_properties = node['sprout']['dropbox']['dmg']

dmg_package 'Dropbox' do
  volumes_dir 'Dropbox Installer'
  source dmg_properties['source']
  checksum dmg_properties['checksum']
  action :install
  owner node['current_user']
end

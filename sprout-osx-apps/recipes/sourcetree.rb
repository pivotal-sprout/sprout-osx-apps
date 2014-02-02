dmg_properties = node['sprout']['sourcetree']['dmg']

dmg_package "SourceTree" do
  volumes_dir "SourceTree"
  source dmg_properties['source']
  checksum dmg_properties['checksum']
  action :install
  owner node['current_user']
end

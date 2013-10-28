dmg_properties = node['sprout']['sourcetree']['dmg']

dmg_package "SourceTree" do
  volumes_dir  dmg_properties['volumes_dir']
  source       dmg_properties['source']
  checksum     dmg_properties['checksum']
  action :install
  owner node['current_user']
end

cmd_properties = node['sprout']['sourcetree']['cmd']

link cmd_properties['path'] do
  to cmd_properties['src']
end


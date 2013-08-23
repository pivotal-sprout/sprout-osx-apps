dmg_properties = node['sprout']['chrome']['dmg']

dmg_package "Google Chrome" do
  dmg_name    dmg_properties['dmg_name']
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  action :install
  owner node['current_user']
end

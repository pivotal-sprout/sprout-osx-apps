dmg_properties = node['sprout']['firefox']['dmg']

dmg_package "Firefox" do
  source   dmg_properties['source']
  checksum dmg_properties['checksum']
  action :install
  owner node['current_user']
end

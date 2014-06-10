dmg_properties = node['sprout']['pacifist']['dmg']

dmg_package "Pacifist" do
  source   dmg_properties['source']
  checksum dmg_properties['checksum']
  dmg_name dmg_properties['dmg_name']
  owner node['current_user']
end

dmg_properties = node['sprout']['skype']['dmg']

dmg_package "Skype" do
  source   dmg_properties['source']
  checksum dmg_properties['checksum']
  owner    node['current_user']
  action   :install
end

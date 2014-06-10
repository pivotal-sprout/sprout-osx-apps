dmg_properties = node['sprout']['emacs']['dmg']

dmg_package "Emacs" do
  dmg_name    dmg_properties['dmg_name']
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  action :install
  owner node['current_user']
end

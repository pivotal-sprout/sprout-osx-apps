include_recipe "sprout-osx-apps::virtualbox"

dmg_properties = node['sprout']['vagrant']['dmg']

dmg_package "Vagrant" do
  source   dmg_properties['source']
  checksum dmg_properties['checksum']
  action :install
  type "pkg"
  owner node['current_user']
  package_id "com.vagrant.vagrant"
end

dmg_properties = node['sprout']['virtualbox']['dmg']

dmg_package "VirtualBox" do
  source dmg_properties['source']
  checksum dmg_properties['checksum']
  action :install
  owner node['current_user']
  type "pkg"
  package_id "org.virtualbox.pkg.virtualbox"
end

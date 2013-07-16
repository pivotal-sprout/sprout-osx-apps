dmg_properties = node['sprout']['gpgtools']['dmg']

dmg_package "GPGTools" do
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  type        dmg_properties['type']
  package_id 'org.gpgtools.*'
  owner node['current_user']
end

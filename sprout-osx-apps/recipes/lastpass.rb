dmg_properties = node['sprout']['lastpass']['dmg']

dmg_package "lpmacosx" do
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  volumes_dir dmg_properties['volumes_dir']
  type        dmg_properties['type']
  package_id  dmg_properties['package_id']
  owner node['current_user']
end

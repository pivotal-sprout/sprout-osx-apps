dmg_properties = node['sprout']['libreoffice']['dmg']

dmg_package "LibreOffice" do
  volumes_dir dmg_properties['volumes_dir']
  source dmg_properties['source']
  checksum dmg_properties['checksum']
  owner node['current_user']
end

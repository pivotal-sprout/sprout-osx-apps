dmg_properties   = node["sprout"]["java"]["dmg"]
dmg_source       = dmg_properties["source"] 
dmg_volumes_dir  = dmg_properties["volumes_dir"]
dmg_checksum     = dmg_properties["checksum"]

dmg_package "JavaForOSX" do
  source dmg_source
  volumes_dir dmg_volumes_dir
  action :install
  type "pkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum dmg_checksum
end

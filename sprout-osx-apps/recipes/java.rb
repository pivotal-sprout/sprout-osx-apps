return unless node["platform"] == "mac_os_x"

dmg_package_source = node["pivotal_workstation"]["java"]["dmg_package"]["source"]
dmg_package_volumes_dir = node["pivotal_workstation"]["java"]["dmg_package"]["volumes_dir"]
dmg_package_checksum = node["pivotal_workstation"]["java"]["dmg_package"]["checksum"]

dmg_package "JavaForOSX" do
  source dmg_package_source
  volumes_dir dmg_package_volumes_dir
  action :install
  type "pkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum dmg_package_checksum
end

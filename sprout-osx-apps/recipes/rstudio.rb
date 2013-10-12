dmg_package node["sprout"]["rstudio"]["package_name"] do
  volumes_dir node["sprout"]["rstudio"]["volumes_dir"]
  source node["sprout"]["rstudio"]["download_uri"]
  checksum node["sprout"]["rstudio"]["checksum"]
  owner node["current_user"]
  action :install
end

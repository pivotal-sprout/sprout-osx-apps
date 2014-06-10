dmg_package node["intellij_ultimate_edition_package_name"] do
  source node["intellij_ultimate_edition_download_uri"]
  checksum node["intellij_ultimate_edition_sha"]
  owner node['current_user']
  action :install
end

dmg_package node["intellij_community_edition_package_name"] do
  source node["intellij_community_edition_download_uri"]
  checksum node["intellij_community_edition_sha"]
  owner node['current_user']
  action :install
end

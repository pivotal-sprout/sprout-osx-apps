osx_majorver = node['platform_version'].split('.')[0,2].join()

source_url = "http://joel.barriere.pagesperso-orange.fr/dl/#{osx_majorver}/OnyX.dmg"

sha256_hash = '94377590c4e08516c5b056d413571dbc747425b472483b25f2fc91c58e97eebd'
onyx_ver = '2.6.9'

dmg_package "Onyx" do
  volumes_dir "Onyx #{onyx_ver}"
  source source_url
  checksum sha256_hash
  action :install
  owner node['current_user']
end

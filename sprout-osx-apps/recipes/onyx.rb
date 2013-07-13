dmg_package "Onyx" do
  volumes_dir "Onyx 2.7.1"
  source "http://joel.barriere.pagesperso-orange.fr/dl/108/OnyX.dmg"
  checksum '94377590c4e08516c5b056d413571dbc747425b472483b25f2fc91c58e97eebd'
  action :install
  owner node['current_user']
end

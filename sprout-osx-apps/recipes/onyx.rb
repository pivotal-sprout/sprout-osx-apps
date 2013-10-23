dmg_package "Onyx" do
  volumes_dir "Onyx 2.7.3"
  source "http://joel.barriere.pagesperso-orange.fr/dl/108/OnyX.dmg"
  checksum '0a94c54851db7d148c4d5db6f035e666dfee8f0d55632739c8eeef98e05bdab8'
  action :install
  owner node['current_user']
end

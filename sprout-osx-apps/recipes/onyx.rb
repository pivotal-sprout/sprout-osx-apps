osx_majorver = node['platform_version'].split('.')[0,2].join()

source_url = case osx_majorver
  when '108', '107', '106'
    "http://joel.barriere.pagesperso-orange.fr/dl/#{osx_majorver}/OnyX.dmg"
  when '105', '104'
    "http://www.titanium.free.fr/download/#{osx_majorver}/OnyX.dmg"
  when '103'
    "http://www.titanium.free.fr/download/#{osx_majorver}/OnyX_153.zip"
  when '102'
   "http://www.titanium.free.fr/download/#{osx_majorver}/OnyX_1.3.1.dmg.gz"
  else
    "http://joel.barriere.pagesperso-orange.fr/dl/#{osx_majorver}/OnyX.dmg"
  end

case osx_majorver
when '108'
  sha256_hash = '94377590c4e08516c5b056d413571dbc747425b472483b25f2fc91c58e97eebd'
  onyx_ver = '2.6.9'
when '107'
  sha256_hash = 'e637359020d3514cf1fe40d1f616692919c41aed926a395bbc7093b256e42e35'
  onyx_ver = '2.4.8'
when '106'
  sha256_hash = '188c15090988b379dce9f0fafa7b686c6eff2ada147cde150b16e1ae01e4e9e4'
  onyx_ver = '2.4.0'
when '105'
  sha256_hash = 'c1dac8094f384d8e61c251d25181d7a151566cb3f39d28c1f5f6ef005c06cbc8'
  onyx_ver = '2.0.6'
when '104'
  sha256_hash = 'c7e26e9a0593a15a287a1f58fae0747d1fede5569a9746378f9149a3426858e8'
  onyx_ver = '1.8.6'
when '103'
  sha256_hash = '1397e5f7455f466d03e36ee71d2b82b26f6a5094c88db6ee90259632e4473d2e'
  onyx_ver = '1.5.3'
when '102'
  sha256_hash = 'ea8dac806737eb04e77b3e7d7391907b07c81cb601f8c9cbc7a6b0025efb79c7'
  onyx_ver = '1.3.1'
else
  raise "A version of OnyX for OSX #{node['platform_version']} is not yet supported by this cookbook"
end

case osx_majorver
when '108', '107', '106', '105', '104'

  dmg_package "Onyx" do
    volumes_dir "Onyx #{onyx_ver}"
    source source_url
    checksum sha256_hash
    action :install
    owner node['current_user']
  end

when '103'
  ## If you really need this...
  ## FIXME: Use ark cookbook to extract OnyX_153.dmg (action :put or :cherry_pick), then use dmg cookbook's LWRP to install as usual
  Chef::Log.error("OSX #{node['platform_version']} is not fully supported by this cookbook.")
when '102'
  ## If you really need this...
  ## FIXME: Use ark cookbook to extract OnyX_1.3.1.dmg, then use dmg cookbook's LWRP to install as usual
  Chef::Log.error("OSX #{node['platform_version']} is not fully supported by this cookbook.")
end
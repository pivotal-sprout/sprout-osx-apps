# Installs Firefox Aurora (pre-beta build of Firefox)
# http://www.mozilla.org/en-US/firefox/aurora/

dmg_package 'Firefox Aurora' do
  config = node['sprout']['firefox_aurora']['dmg']
  volumes_dir config['volumes_dir']
  app config['app']
  source config['source']
  checksum config['checksum']
  action :install
  owner node['current_user']
end

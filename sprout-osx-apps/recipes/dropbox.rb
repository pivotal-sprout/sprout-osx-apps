include_recipe "sprout-osx-base::addloginitem"

dmg_package "Dropbox" do
  volumes_dir "Dropbox Installer"
  source "https://www.dropbox.com/download?plat=mac"
  checksum "1169d604ed3db8b15449753f7cf9c5af2b86afefcf598231d44dc29551c4a489"
  action :install
  owner node['current_user']
  notifies :run, "execute[Start Dropbox on login]"
end

app_path ="/Applications/Dropbox.app"

execute "Start Dropbox on login" do
  command "addloginitem #{app_path}"
  user node['current_user']
  action :nothing
end

include_recipe "pivotal_workstation::addloginitem"

dmg_package "Alfred" do
  volumes_dir "Alfred.app"
  source "http://cachefly.alfredapp.com/alfred_1.3.1_261.dmg"
  checksum "c951c4dc05ff1091359358d710142cabef2c190be41f799244669f879cff7e80"
  action :install
  owner node['current_user']
  notifies :run, "execute[Start Alfred on login]"
end

app_path ="/Applications/Alfred.app"

execute "Start Alfred on login" do
  command "addloginitem #{app_path}"
  user node['current_user']
  action :nothing
end

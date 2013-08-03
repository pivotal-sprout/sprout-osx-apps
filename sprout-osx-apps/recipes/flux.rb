include_recipe "sprout-osx-base::addloginitem"

remote_file "#{Chef::Config[:file_cache_path]}/Flux.zip" do
  source node["flux_download_uri"]
  checksum node["flux_download_checksum"]
  mode "0644"
  not_if { File.exists?("/Applications/Flux.app") }
end

execute "unzip flux" do
  command "unzip -q #{Chef::Config[:file_cache_path]}/Flux.zip Flux.app/* -d /Applications/"
  user node['current_user']
  group "admin"
  not_if { File.exists?("/Applications/Flux.app") }
  notifies :run, "execute[Start Flux on login]"
end

app_path ="/Applications/Flux.app"

execute "Start Flux on login" do
  command "addloginitem #{app_path}"
  user node['current_user']
  action :nothing
end

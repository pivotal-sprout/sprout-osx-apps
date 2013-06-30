include_recipe "pivotal_workstation::addloginitem"

unless File.exists?("/Applications/SizeUp.app")
  include_recipe "pivotal_workstation::enable_assistive_devices"

  remote_file "#{Chef::Config[:file_cache_path]}/sizeup.zip" do
    source node["sizeup_download_uri"]
    mode "0644"
  end

  execute "unzip sizeup" do
    command "unzip #{Chef::Config[:file_cache_path]}/sizeup.zip SizeUp.app/* -d /Applications/"
    user node['current_user']
    group "admin"
    notifies :run, "execute[Start SizeUp on login]"
  end

  app_path = "/Applications/SizeUp.app"

  # start up on login
  execute "Start SizeUp on login" do
    command "addloginitem #{app_path}"
    user node['current_user']
    action :nothing
  end

end

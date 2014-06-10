unless File.exists?("/Applications/SizeUp.app")
  include_recipe "sprout-osx-settings::enable_assistive_devices"

  remote_file "#{Chef::Config[:file_cache_path]}/sizeup.zip" do
    source node["sizeup_download_uri"]
    mode "0644"
  end

  # start up on login
  execute "Start SizeUp automatically" do
    command "defaults write loginwindow AutoLaunchedApplicationDictionary -array-add '{ \"Path\" = \"/Applications/SizeUp.app\"; \"Hide\" = 0; }'"
    user node['current_user']
  end

  execute "unzip sizeup" do
    command "unzip #{Chef::Config[:file_cache_path]}/sizeup.zip SizeUp.app/* -d /Applications/"
    user node['current_user']
    group "admin"
  end
end

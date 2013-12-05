unless File.exists?("/Applications/Spectacle.app")
  remote_file "#{Chef::Config[:file_cache_path]}/spectacle.zip" do
    source node["spectacle_download_url"]
    mode "0644"
  end

  execute "Start Spectacle automatically" do
    command "defaults write loginwindow AutoLaunchedApplicationDictionary -array-add '{ \"Path\" = \"/Applications/Spectacle.app\"; \"Hide\" = 0; }'"
    user node['current_user']
  end

  execute "unzip spectacle" do
    command "unzip #{Chef::Config[:file_cache_path]}/spectacle.zip Spectacle.app/* -d /Applications/"
    user node['current_user']
    group "admin"
  end
end


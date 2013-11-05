unless File.exists?("/Applications/Alfred 2.app")
  remote_file "#{Chef::Config[:file_cache_path]}/alfred2.zip" do
    source node["alfred_download_uri"]
    mode "0644"
  end

  execute "unzip Alfred" do
    command "unzip #{Chef::Config[:file_cache_path]}/alfred2.zip -d /Applications/"
    user node['current_user']
    group "admin"
  end
end

unless File.exists?("/Applications/Skitch.app")
  remote_file "#{Chef::Config[:file_cache_path]}/skitch.zip" do
    source node["skitch_download_url"]
    mode "0644"
  end

  execute "unzip skitch" do
    command "unzip #{Chef::Config[:file_cache_path]}/skitch.zip Skitch.app/* -d /Applications/"
    user node['current_user']
    group "admin"
  end
end


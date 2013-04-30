unless File.exists?(node["propane_app_path"])

  remote_file "#{Chef::Config[:file_cache_path]}/propane.zip" do
    source node["propane_download_uri"]
    owner node['current_user']
  end

  execute "unzip propane" do
    command "unzip #{Chef::Config[:file_cache_path]}/propane.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy propane to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Propane.app #{Regexp.escape(node["propane_app_path"])}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if Propane.app was installed" do
    block do
      raise "Propane.app was not installed" unless File.exists?(node["propane_app_path"])
    end
  end

end

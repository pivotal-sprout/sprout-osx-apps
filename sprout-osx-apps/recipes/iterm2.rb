unless File.exists?(node["iterm2_app_path"])

  remote_file "#{Chef::Config[:file_cache_path]}/iTerm2.zip" do
    source node["iterm2_download_url"]
    owner node['current_user']
    checksum node["iterm2_checksum"]
  end

  execute "unzip iterm2" do
    command "unzip #{Chef::Config[:file_cache_path]}/iTerm2.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy iterm2 to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/iTerm.app #{Regexp.escape(node["iterm2_app_path"])}"
    user node['current_user']
    group "admin"
  end

  cookbook_file "/Users/#{node['current_user']}/Library/Preferences/com.googlecode.iterm2.plist" do
    source "com.googlecode.iterm2.plist"
    user node['current_user']
    mode "0600"
  end

end

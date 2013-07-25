app_properties = node['sprout']['iterm2']['app']
dmg_properties = node['sprout']['iterm2']['dmg']

unless File.exists?(app_properties['path'])

  remote_file "#{Chef::Config[:file_cache_path]}/iTerm2.zip" do
    source dmg_properties['source']
    checksum dmg_properties['checksum']
    owner node['current_user']
  end

  execute "unzip iterm2" do
    command "unzip #{Chef::Config[:file_cache_path]}/iTerm2.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "move iterm2 to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/iTerm.app #{Regexp.escape(app_properties['path'])}"
    user node['current_user']
    group "admin"
  end

  cookbook_file "/Users/#{node['current_user']}/Library/Preferences/com.googlecode.iterm2.plist" do
    source "com.googlecode.iterm2.plist"
    user node['current_user']
    mode "0600"
  end

end

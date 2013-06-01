unless File.exists?("/Applications/Bartender.app")

  remote_file "#{Chef::Config[:file_cache_path]}/Bartender.zip" do
    source "http://www.macbartender.com/Demo/Bartender.zip"
    owner node['current_user']
  end

  execute "unzip Bartender" do
    command "unzip #{Chef::Config[:file_cache_path]}/Bartender.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy Bartender to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Bartender.app #{Regexp.escape("/Applications/Bartender.app")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if Bartender.app was installed" do
    block do
      raise "Bartender.app was not installed" unless File.exists?("/Applications/Bartender.app")
    end
  end

end




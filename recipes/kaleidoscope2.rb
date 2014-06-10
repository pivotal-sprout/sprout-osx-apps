unless File.exists?("/Applications/Kaleidoscope.app")

  remote_file "#{Chef::Config[:file_cache_path]}/kaleidoscope2.tar.gz" do
    source "https://updates.blackpixel.com/latest-beta?app=ks"
    owner node['current_user']
  end

  execute "unzip Kaleidoscope" do
    command "tar -xzf #{Chef::Config[:file_cache_path]}/kaleidoscope2.tar.gz -C #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy Kaleidoscope to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Kaleidoscope.app #{Regexp.escape("/Applications/Kaleidoscope.app")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if Kaleidoscope.app was installed" do
    block do
      raise "Kaleidoscope.app was not installed" unless File.exists?("/Applications/Kaleidoscope.app")
    end
  end

end




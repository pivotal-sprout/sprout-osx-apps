file_properties = node['sprout']['alfred']

unless File.exists?("/Applications/#{file_properties['app_name']}")
  remote_file "#{Chef::Config[:file_cache_path]}/#{file_properties['filename']}" do
    source file_properties['source']
    owner node['current_user']
    checksum file_properties['checksum']
  end

  execute "unzip Alfred" do
    command "unzip #{Chef::Config[:file_cache_path]}/#{file_properties['filename']} -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy Alfred to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/#{Regexp.escape(file_properties['app_name'])} #{Regexp.escape("/Applications/#{file_properties['app_name']}")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if 1Password.app was installed" do
    block do
      raise "#{file_properties['app_name']} was not installed" unless File.exists?("/Applications/#{file_properties['app_name']}")
    end
  end

end

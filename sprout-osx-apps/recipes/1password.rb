unless File.exists?("/Applications/1Password.app")

  remote_file "#{Chef::Config[:file_cache_path]}/1password.zip" do
    source node['sprout']['1password']['zip']['source']
    owner node['current_user']
    checksum node['sprout']['1password']['zip']['checksum']
  end

  execute "unzip 1password" do
    command "unzip -o #{Chef::Config[:file_cache_path]}/1password.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy 1password to /Applications" do
    command "mv #{Regexp.escape("#{Chef::Config[:file_cache_path]}/#{node['sprout']['1password']['zip']['appname']}")} #{Regexp.escape("/Applications/1Password.app")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if 1Password.app was installed" do
    block do
      raise "1Password.app was not installed" unless File.exists?("/Applications/1Password.app")
    end
  end

end




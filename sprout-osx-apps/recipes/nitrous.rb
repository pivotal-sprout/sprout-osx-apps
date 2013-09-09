source   = node['sprout']['nitrous']['source']
checksum = node['sprout']['nitrous']['checksum']
app      = node['sprout']['nitrous']['app']
zip = File.basename(source)

unless File.exists?("/Applications/#{app}")
  remote_file "#{Chef::Config[:file_cache_path]}/#{zip}" do
    source source
    checksum checksum
    owner node['current_user']
  end

  execute "unzip nitrous into /Applications" do
    command "unzip #{Chef::Config[:file_cache_path]}/#{zip} -d /Applications"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if #{app} was installed" do
    block do
      raise "#{app} was not installed" unless File.exists?("/Applications/#{app}")
    end
  end
end

url = node['sprout']['hipchat']['url']
app = node['sprout']['hipchat']['app']
zip = File.basename(url)

unless File.exists?("/Applications/#{app}")
  remote_file "#{Chef::Config[:file_cache_path]}/#{zip}" do
    source url
    owner node['current_user']
  end

  execute "unzip hipchat" do
    command "unzip #{Chef::Config[:file_cache_path]}/#{zip} -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy hipchat to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/#{app} #{Regexp.escape("/Applications/#{app}")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if #{app} was installed" do
    block do
      raise "#{app} was not installed" unless File.exists?("/Applications/#{app}")
    end
  end
end

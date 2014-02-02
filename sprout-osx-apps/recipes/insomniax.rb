appname = 'InsomniaX'

unless File.exists?("/Applications/#{appname}.app")

  remote_file "#{Chef::Config[:file_cache_path]}/InsomniaX.tgz" do
    source node['sprout']['insomniax']['tgz']['source']
    owner node['current_user']
    checksum node['sprout']['insomniax']['tgz']['checksum']
  end

  execute "unzip #{appname}" do
    command "gunzip -c '#{Chef::Config[:file_cache_path]}/#{appname}.tgz' | tar xopf -"
    user node['current_user']
  end

  execute "copy #{appname} to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/#{appname}.app #{Regexp.escape("/Applications/#{appname}.app")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if #{appname}.app was installed" do
    block do
      raise "#{appname}.app was not installed" unless File.exists?("/Applications/#{appname}.app")
    end
  end

end


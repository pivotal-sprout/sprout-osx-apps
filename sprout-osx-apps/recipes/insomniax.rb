appname = 'InsomniaX'
source_properties = node['sprout']['insomniax']['tgz']

unless File.exists?("/Applications/#{appname}.app")

  remote_file "#{Chef::Config[:file_cache_path]}/#{appname}.tgz" do
    source source_properties['source']
    owner node['current_user']
    checksum source_properties['checksum']
  end

  execute "unpack #{appname}" do
    command "gunzip -c '#{Chef::Config[:file_cache_path]}/#{appname}.tgz' | tar xopf -"
    cwd Chef::Config[:file_cache_path]
    user node['current_user']
    only_if source_properties['type'] == 'tgz'
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


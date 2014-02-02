dmg_properties = node['sprout']['insomniax']['tgz']
appname = 'InsomniaX'

unless File.exists?("/Applications/InsomniaX.app")

  remote_file "#{Chef::Config[:file_cache_path]}/#{appname}.tgz" do
    source "#{dmg_properties['tgz']['source']}"
    owner node['current_user']
    checksum "#{dmg_properties['tgz']['checksum']}"
  end

  execute "unzip 1password" do
    command "gunzip -c '#{Chef::Config[:file_cache_path]}/#{appname}.tgz' | tar xopf -"
    user node['current_user']
  end

  execute "copy #{appname} to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/#{appname}.app #{Regexp.escape("/Applications/#{appname}.app")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if 1Password.app was installed" do
    block do
      raise "#{appname}.app was not installed" unless File.exists?("/Applications/#{appname}.app")
    end
  end

end


zip_properties = node['sprout']['cyberduck']['zip']
archive_path = "#{Chef::Config[:file_cache_path]}/CyberDuck.zip"
app_install_path = File.join( node['sprout']['cyberduck']['install_dir'], zip_properties['app_bundle_name'] )
install_dir = node['sprout']['cyberduck']['install_dir']

remote_file archive_path do
  source   zip_properties['source']
  checksum zip_properties['checksum']
  owner node['current_user']
  action :create_if_missing
end

execute "unzip CyberDuck to #{install_dir}" do
  command "unzip -q -o #{archive_path} -x __MACOSX* -d #{install_dir}/"
  user node['current_user']
  not_if { File.exists?(app_install_path) }
  # This is required to unzip into Applications
  group "admin"
end

ruby_block "test to see if CyberDuck was installed" do
  block do
    raise "CyberDuck install failed" unless File.exists?(app_install_path)
  end
end

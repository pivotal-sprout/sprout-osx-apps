zip_properties = node['sprout']['hiss']['zip']
archive_path = "#{Chef::Config[:file_cache_path]}/Hiss.zip"
app_install_path = File.join( node['sprout']['hiss']['install_dir'], zip_properties['app_bundle_name'] )
install_dir = node['sprout']['hiss']['install_dir']

remote_file archive_path do
  source   zip_properties['source']
  checksum zip_properties['checksum']
  owner node['current_user']
  action :create_if_missing
end

execute "unzip Hiss to #{install_dir}" do
  command "unzip -q -o #{archive_path} -x __MACOSX* -d #{install_dir}/"
  user node['current_user']
  not_if { File.exists?(app_install_path) }
  # This is required to unzip into Applications
  group "admin"
end

ruby_block "test to see if Hiss was installed" do
  block do
    raise "Hiss install failed" unless File.exists?(app_install_path)
  end
end

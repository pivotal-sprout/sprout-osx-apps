source    = node["sprout"]["macvim"]["source"]
checksum  = node["sprout"]["macvim"]["checksum"]
extracted = node["sprout"]["macvim"]["extracted"]
app       = node["sprout"]["macvim"]["app"]
bin       = node["sprout"]["macvim"]["bin"]

archive_name = File.basename(source)
archive_path = "#{Chef::Config[:file_cache_path]}/#{archive_name}"

remote_file archive_path do
  source source
  checksum checksum
  owner node['current_user']
end

execute "extract #{archive_path}" do
  command "tar -xvf #{archive_path} -C #{Chef::Config[:file_cache_path]}/"
  not_if "test -e #{Chef::Config[:file_cache_path]}/#{extracted}"
end

execute "place #{app} in /Applications" do
  command "cp -R #{Chef::Config[:file_cache_path]}/#{extracted}/#{app} /Applications/"
  user node['current_user']
  group "admin"
  not_if "test -e /Applications/#{app}"
end

include_recipe "sprout-osx-base::user_owns_usr_local"
execute "place #{bin} to /usr/local/bin" do
  command "cp  #{Chef::Config[:file_cache_path]}/#{extracted}/#{bin} /usr/local/bin/"
  not_if "test -e /usr/local/bin/#{bin}"
end

download_uri = 'http://downloads.selfcontrolapp.com/SelfControl-1.5.1.zip'
download_checksum = 'd3823a1e9ba0b47dc2cb39c93cd51837c2dafc7d5a5a564825f4a440fd2ab9ad'

remote_file "#{Chef::Config[:file_cache_path]}/SelfControl.zip" do
  source download_uri
  checksum download_checksum
  mode "0644"
  not_if { File.exists?("/Applications/SelfControl.app") }
end

execute "unzip self control" do
  command "unzip -q #{Chef::Config[:file_cache_path]}/SelfControl.zip SelfControl.app/* -d /Applications/"
  user node['current_user']
  group "admin"
  not_if { File.exists?("/Applications/SelfControl.app") }
end


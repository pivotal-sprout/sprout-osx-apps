# install MSoffice (you need to provide license afterwards)
# Script taken from here: http://www.tuaw.com/2013/12/22/microsoft-office-2011-unattended-download-and-installation/
# NOT IDEMPOTENT CURRENTLY


remote_file "#{Chef::Config[:file_cache_path]}/office2011.sh" do
  source 'https://raw.github.com/tjluoma/office2011/master/office2011.sh'
  owner node['current_user']
  mode '700'
  not_if { File.not_exists?('/Applications/Microsoft Office 2011' }
end

execute "install msoffice" do
  command "#{Chef::Config[:file_cache_path]}/office2011.sh"
  cwd Chef::Config[:file_cache_path]
  user node['current_user']
  not_if { File.not_exists?('/Applications/Microsoft Office 2011' }
end
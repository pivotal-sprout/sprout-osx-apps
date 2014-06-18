include_recipe 'sprout-base::addloginitem'

app_path = "/Applications/#{node['sprout']['table_tennis_time']['application_name']}"

remote_file 'download TableTennisTime' do
  checksum node['sprout']['table_tennis_time']['zip']['checksum']
  path "#{Chef::Config[:file_cache_path]}/TableTennisTime.app.zip"
  source node['sprout']['table_tennis_time']['zip']['url']
  group 'admin'
  user node['current_user']
  not_if { File.exists? app_path }
end

execute 'unzip TableTennisTime' do
  command "unzip -q #{Chef::Config[:file_cache_path]}/TableTennisTime.app.zip -d #{Chef::Config[:file_cache_path]}/"
  group 'admin'
  user node['current_user']
  not_if { File.exists? app_path }
end

execute 'move TableTennisTime to /Applications' do
  command "mv #{Chef::Config[:file_cache_path]}/#{node['sprout']['table_tennis_time']['application_name']} /Applications/"
  group 'admin'
  user node['current_user']
  not_if { File.exists? app_path }
  notifies :run, 'execute[start TableTennisTime on login]'
end

execute "start TableTennisTime on login" do
  command "su #{node['current_user']} -c \"addloginitem #{app_path}\""
  action :nothing
end

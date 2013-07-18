include_recipe "sprout-osx-base::addloginitem"

app_path="/Applications/ShiftIt.app"

unless File.exists?(app_path)
  remote_file "#{Chef::Config[:file_cache_path]}/ShiftIt.zip" do
    source "https://raw.github.com/onsi/ShiftIt/master/ShiftIt.zip"
    mode "0644"
  end

  execute "unzip ShiftIt" do
    command "unzip #{Chef::Config[:file_cache_path]}/ShiftIt.zip ShiftIt.app/* -d /Applications/"
    user node['current_user']
    group "admin"
  end

  # start up on login
  execute "Start ShiftIt on login" do
    command "su #{node['current_user']} -c \"addloginitem #{app_path}\""
  end
end

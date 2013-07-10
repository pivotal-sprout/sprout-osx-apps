execute "clear the Terminal apps save state" do
  command "rm -rf #{ENV['HOME']}/Library/Saved\\ Application\\ State/com.apple.Terminal.savedState"
  user node['current_user']
  ignore_failure true
end

osx_defaults "Set terminal profile to #{node['terminal']['profile']}" do
  domain 'com.apple.Terminal'
  key 'Default Window Settings'
  string node['terminal']['profile']
end

osx_defaults "Set startup terminal profile to #{node['terminal']['profile']}" do
  domain 'com.apple.Terminal'
  key 'Startup Window Settings'
  string node['terminal']['profile']
end

remote_file "#{Chef::Config[:file_cache_path]}/MenloRegular18pt.bin" do
  source "http://cheffiles.pivotallabs.com/MenloRegular18pt.bin"
  owner node['current_user']
end

execute "Updates font on the #{node['terminal']['profile']} profile to Menlo-Regular 18pt" do
  command "/usr/libexec/PlistBuddy -c 'import :Window\\ Settings:#{node['terminal']['profile']}:Font #{Chef::Config[:file_cache_path]}/MenloRegular18pt.bin' #{ENV['HOME']}/Library/Preferences/com.apple.Terminal.plist"
  user node['current_user']
end

execute "Turns on Anti-Aliasing for the #{node['terminal']['profile']} profile's font" do
  command "/usr/libexec/PlistBuddy -c 'set :Window\\ Settings:#{node['terminal']['profile']}:FontAntialias true' #{ENV['HOME']}/Library/Preferences/com.apple.Terminal.plist"
  user node['current_user']
end

ruby_block "let's see what it looks like" do
  block do
    puts `/usr/libexec/PlistBuddy -c 'print :Window\\ Settings:#{node['terminal']['profile']}:Font ' #{ENV['HOME']}/Library/Preferences/com.apple.Terminal.plist | strings`
  end
end


execute 'killall Finder; killall Dock; killall SystemUIServer'

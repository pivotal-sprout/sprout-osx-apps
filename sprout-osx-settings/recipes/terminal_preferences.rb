if (system("ps auxwww | grep -i terminal.app |grep -v grep"))
  Chef::Log.warn "\033[31m The '#{File.basename(__FILE__)}' recipe works inconsistently while Terminal is running\033[39m"
else
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

  execute "Closes window when shell exits cleanly the #{node['terminal']['profile']} profile" do
    command "/usr/libexec/PlistBuddy -c 'set :Window\\ Settings:#{node['terminal']['profile']}:shellExitAction 1' #{ENV['HOME']}/Library/Preferences/com.apple.Terminal.plist"
    user node['current_user']
  end

  execute 'killall cfprefsd'
end

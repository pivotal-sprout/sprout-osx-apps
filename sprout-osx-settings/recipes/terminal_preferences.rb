osx_defaults "Set terminal color scheme to #{node['terminal']['profile']}" do
  domain 'com.apple.Terminal'
  key 'Default Window Settings'
  string node['terminal']['profile']
end

osx_defaults "Set startup terminal color scheme to #{node['terminal']['profile']}" do
  domain 'com.apple.Terminal'
  key 'Startup Window Settings'
  string node['terminal']['profile']
end

execute "Updates font to Menlo-Regular 18pt" do
  command "/usr/libexec/PlistBuddy -c 'import :\"Window Settings\":Pro:Font /tmp/MenloRegular18pt.bin' #{ENV['HOME']}/Library/Preferences/com.apple.Terminal.plist"
  user node['current_user']
end

ruby_block "let's see what it looks like" do
  block do
    puts `/usr/libexec/PlistBuddy -c 'print :"Window Settings":Pro:Font ' #{ENV['HOME']}/Library/Preferences/com.apple.Terminal.plist | strings`
  end
end


execute 'killall Finder; killall Dock; killall SystemUIServer'

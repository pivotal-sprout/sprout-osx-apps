app = node['sprout']['hipchat']['app']
app_plist = "#{node['sprout']['home']}/Library/Preferences/com.hipchat.HipChat.plist"

homebrew_cask "hipchat"

execute "open /Applications/#{app}; osascript -e 'tell application \"#{app}\" to quit'" do
  not_if { ::File.exists?(app_plist) }
end

node['sprout']['hipchat']['settings'].each do |name, type, value|
  execute "/usr/libexec/PlistBuddy -c 'Add #{name} #{type} #{value}' #{app_plist}" do
    not_if "/usr/libexec/PlistBuddy -c 'Print #{name}' #{app_plist}"
  end

  execute "/usr/libexec/PlistBuddy -c 'Set #{name} #{value}' #{app_plist}" do
    only_if "/usr/libexec/PlistBuddy -c 'Print #{name}' #{app_plist}"
  end
end

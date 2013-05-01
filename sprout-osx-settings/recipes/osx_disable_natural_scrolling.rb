osx_defaults "Disable natural scrolling" do
  domain "/Users/#{node['current_user']}/Library/Preferences/.GlobalPreferences"
  key "com.apple.swipescrolldirection"
  boolean false
end

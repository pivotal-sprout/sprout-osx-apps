homebrew_cask "iterm2"

cookbook_file "/Users/#{node['sprout']['user']}/Library/Preferences/com.googlecode.iterm2.plist" do
  source "com.googlecode.iterm2.plist"
  user node['sprout']['user']
  mode "0600"
end

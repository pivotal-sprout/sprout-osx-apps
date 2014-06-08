homebrew_cask "iterm2"

cookbook_file "/Users/#{node['current_user']}/Library/Preferences/com.googlecode.iterm2.plist" do
  source "com.googlecode.iterm2.plist"
  user node['current_user']
  mode "0600"
end

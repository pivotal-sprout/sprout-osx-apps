osx_defaults "set key repeat rate" do
  domain "/Users/#{node['current_user']}/Library/Preferences/.GlobalPreferences"
  key "KeyRepeat"
  integer node['keyboard_preferences']['key_repeat_rate_lower_is_faster']
  only_if { node['keyboard_preferences']['key_repeat_rate_lower_is_faster'] }
end

osx_defaults "set initial key repeat delay" do
  domain "/Users/#{node['current_user']}/Library/Preferences/.GlobalPreferences"
  key "InitialKeyRepeat"
  integer node['keyboard_preferences']['initial_repeat_delay_lower_is_shorter']
  only_if { node['keyboard_preferences']['initial_repeat_delay_lower_is_shorter'] }
end

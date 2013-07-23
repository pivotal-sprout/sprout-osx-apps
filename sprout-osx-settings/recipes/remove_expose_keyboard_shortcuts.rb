include_recipe "sprout-osx-settings::enable_assistive_devices"

["all windows", "application windows", "show desktop", "dashboard" ].each do |shortcut_name|
ruby_block "Remove Expose Keyboard Shortcut for '#{shortcut_name}'" do
  block do
    system(
    "osascript -e '
      tell application \"System Events\"
        if UI elements enabled then
          tell expose preferences
            set the properties of the #{shortcut_name} shortcut to {function key:none, function key modifiers:{none}}
            set the properties of the #{shortcut_name} shortcut to {function key:none}
          end tell
        else
          tell application \"System Preferences\"
            activate
            set current pane to pane \"com.apple.preference.universalaccess\"
            display dialog \"UI element scripting is not enabled. Check \\\"Enable access for assistive devices\\\"\"
          end tell
        end if
      end tell'"
    )
  end
  not_if { system("osascript -e '
              tell application \"System Events\"
                tell expose preferences
                  get the properties of the #{shortcut_name} shortcut
                end tell
              end tell' | grep -q 'function key:none, function key modifiers:,'")
          }
  end
end

ruby_block "Quit System Preferences" do
  block do
    system(
    "osascript -e '
      if application \"System Preferences\" is running then
        tell application \"System Preferences\" to quit
      end if'"
    )
  end
end

app_path = "/usr/bin/VirtualBox"

unless File.exists?(app_path)
  sprout_osx_apps_homebrew_cask "virtualbox"
end

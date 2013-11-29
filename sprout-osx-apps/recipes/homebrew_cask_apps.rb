include_recipe "sprout-osx-apps::homebrew_cask"

node["brew_cask_applications"].each do |application|
  sprout_osx_apps_homebrew_cask application
end
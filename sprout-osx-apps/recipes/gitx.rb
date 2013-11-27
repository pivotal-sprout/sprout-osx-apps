sprout_osx_apps_homebrew_cask "gitx-rowanj"

cmd_properties = node['sprout']['gitx']['cmd']

link cmd_properties['path'] do
  to cmd_properties['src']
end


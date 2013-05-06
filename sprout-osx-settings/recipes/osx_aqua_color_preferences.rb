aqua_color_variant_blue = 1
aqua_color_variant_graphite = 6

osx_defaults "Set aqua appearance color variant" do
  domain "/Users/#{node['current_user']}/Library/Preferences/.GlobalPreferences"
  key "AppleAquaColorVariant"
  integer aqua_color_variant_graphite
end

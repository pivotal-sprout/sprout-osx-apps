include_recipe "sprout-osx-apps::xquartz"

package "qt" do
  options "--HEAD"
end

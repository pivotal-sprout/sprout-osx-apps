include_recipe "sprout-base::addloginitem"

app_path ="/Applications/Flux.app"

unless File.exists?(app_path)
  homebrew_cask "f-lux"

  execute "Start Flux on login" do
    command "addloginitem #{app_path}"
    user node['current_user']
  end
end

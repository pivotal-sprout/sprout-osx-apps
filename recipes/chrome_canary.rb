dmg_package "Google Chrome Canary" do
  dmg_name "GoogleChromeCanary"
  source "https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg"
  action :install
  owner node['current_user']
end

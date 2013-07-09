node.default["background_host"] = "http://cheffiles.pivotallabs.com"
node.default["backgrounds"]["primary"] = %w{blue}.map do |color|
  "pivID_#{color}-1004x400.png"
end
node.default["backgrounds"]["secondary"] = ["BackToTheEdward.png"]
node.default['login_icon'] = "tracker_dot"

node['backgrounds'].each do |level, filenames|
  directory "#{node['sprout']['home']}/Pictures/Backgrounds#{level.capitalize}" do
    mode "0755"
    owner node['current_user']
    recursive true
  end

  filenames.each do |filename|
    remote_file "#{node['sprout']['home']}/Pictures/Backgrounds#{level.capitalize}/#{filename}" do
      source "#{node['background_host']}/#{filename}"
      owner node['current_user']
      action :create_if_missing
    end
  end
end

directory "#{node['sprout']['home']}/Pictures/Icons" do
  mode "0755"
  owner node['current_user']
  recursive true
end

["#{node['login_icon']}.png", "#{node['login_icon']}.jpeg"].each do |filename|
  remote_file "#{node['sprout']['home']}/Pictures/Icons/#{filename}" do
    filename = filename.gsub(" ","%20")
    source "#{node['background_host']}/#{filename}"
    owner node['current_user']
    action :create_if_missing
  end
end

template "#{Chef::Config[:file_cache_path]}/jpegphoto.dsimport" do
  source "pivotal_logos-dsimport.erb"
  owner node['current_user']
end

run_unless_marker_file_exists("pivotal_logos") do
  # Let's make Pivotal Logos less intrusive; assume
  # they want the logos the first time soloist is run,
  # but afterwards leave the backgrounds & icons untouched
  # (using a marker file)
  #
  # BUGS:  the screen-share-lock icon will NOT refresh to the
  # red dot until you log out & log in again.


  # OpenDirectory has a specific format for JPEGPhoto (320x320 72dpi)
  # easiest way to create one is to let Apple create it for you and
  # then extract their jpeg:
  # System Preferences
  #   ->Users & Groups
  #     ->select your username->click on icon->click "Edit Picture..."
  #     ->set your picture to the one you want.  Then:
  # dscl . read /Users/$USER JPEGPhoto |tail +2 |xxd -r -p > #{Chef::Config[:file_cache_path]}/precious.jpeg
  execute("dscl . delete /Users/#{node['current_user']} JPEGPhoto")
  execute("dscl . create /Users/#{node['current_user']} Picture \"#{node['sprout']['home']}/Pictures/Icons/#{node['login_icon']}.png\"")
  execute("dsimport #{Chef::Config[:file_cache_path]}/jpegphoto.dsimport /Local/Default M")

  execute "install the pivotal backgrounds" do
    command "/usr/libexec/PlistBuddy #{ENV['HOME']}/Library/Preferences/com.apple.desktop.plist <<EOF
add    :Background:spaces:placeholder:0:BackgroundColor array
add    :Background:spaces:placeholder:0:BackgroundColor:0 real 0.87058824300766
add    :Background:spaces:placeholder:0:BackgroundColor:1 real 0.866666674613953
add    :Background:spaces:placeholder:0:BackgroundColor:2 real 0.866666674613953
add    :Background:spaces:placeholder:0:Change string \"Never\"
add    :Background:spaces:placeholder:0:ChangePath string \"#{ENV['HOME']}/Pictures/BackgroundsPrimary\"
add    :Background:spaces:placeholder:0:NewChangePath string \"#{ENV['HOME']}/Pictures/BackgroundsPrimary\"
add    :Background:spaces:placeholder:0:ChangeTime real 1800
add    :Background:spaces:placeholder:0:DSKDesktopPrefPane dict
add    :Background:spaces:placeholder:0:DSKDesktopPrefPane:UserFolderPaths array
add    :Background:spaces:placeholder:0:DSKDesktopPrefPane:UserFolderPaths:0 string \"#{ENV['HOME']}/Pictures/BackgroundsPrimary\"
add    :Background:spaces:placeholder:0:DSKDesktopPrefPane:UserFolderPaths:1 string \"#{ENV['HOME']}/Pictures/BackgroundsSecondary\"
add    :Background:spaces:placeholder:0:DrawBackgroundColor bool \"true\"
add    :Background:spaces:placeholder:0:ImageFilePath string \"#{ENV['HOME']}/Pictures/BackgroundsPrimary/pivID_blue-1004x400.png\"
add    :Background:spaces:placeholder:0:NewImageFilePath string \"#{ENV['HOME']}/Pictures/BackgroundsPrimary/pivID_blue-1004x400.png\"
add    :Background:spaces:placeholder:0:NoImage bool \"false\"
add    :Background:spaces:placeholder:0:Placement string \"Centered\"
add    :Background:spaces:placeholder:0:Random bool \"false\"
copy   :Background:spaces:placeholder:0 :Background:spaces:placeholder:default
# Note: the key \"placeholder\" is a placeholder for a null key
# PlistBuddy doesn't handle null keys well; our workaround is to
# use a placeholder and then, once the tree is populated, copy
# it into place and delete the placeholder
copy   :Background:spaces:placeholder   :Background:spaces::
delete :Background:spaces:placeholder
save
EOF"
    user node['current_user']
    ignore_failure true # exit 1 doesn't necessarily mean failure
  end

  execute "restart Dock" do
    command "killall Dock"
    user node['current_user']
    ignore_failure true # Dock might not be running if ssh-ing in
  end
end

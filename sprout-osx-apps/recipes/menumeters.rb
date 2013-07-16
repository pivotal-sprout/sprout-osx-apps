menu_meters_uri = "http://www.ragingmenace.com/software/download/MenuMeters.dmg"
menu_meters_dmg = Chef::Config[:file_cache_path] + "/MenuMeters.dmg"
menu_meters_mnt = "/Volumes/MenuMeters 1.6.1"
menu_meters_src = menu_meters_mnt + "/MenuMeters Installer.app/Contents/Resources/MenuMeters.prefPane"
menu_meters_destdir = "/Library/PreferencePanes/"
menu_meters_dst = menu_meters_destdir + "MenuMeters.prefPane"

unless File.exists?(menu_meters_dst)

  remote_file menu_meters_dmg do
    source menu_meters_uri
    mode "0644"
    checksum "aa92266a783eb0e9782ba6701d13c3c465cbc65708b169f188f22a8c9fbd4c50"
  end

  execute "mount MenuMeters dmg" do
    command "hdiutil attach #{menu_meters_dmg}"
    user node['current_user']
  end

  # We're bypassing the installer.app because it requires user intervention.
  # FIXME: use FileUtils.cp_r instead of forking out to cp.
  execute "Copy MenuMeters to /Library/PreferencePanes/" do
    command "cp -rf #{Regexp.escape(menu_meters_src)} #{Regexp.escape(menu_meters_destdir)}"
  end

  execute "unmount dmg" do
    command "hdiutil detach #{Regexp.escape(menu_meters_mnt)}"
    user node['current_user']
  end

  # Can't use defaults(1) because we need to insert MenuMeters at the _beginning_
  # of the plist so that it doesn't push the clock to the left.  We need plist gem.
  gem_package("plist")

  plist_file = "#{ENV['HOME']}/Library/Preferences/com.apple.systemuiserver.plist"

  ruby_block "Put MenuMeters on the Menubar" do
    block do
      Gem.clear_paths
      require 'rubygems'
      require 'plist'
      `plutil -convert xml1 #{plist_file}`
      ui_plist = Plist::parse_xml(plist_file)
      ui_plist['menuExtras'] ||= Array.new
      ui_plist['menuExtras'].unshift(
      '/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMeterNet.menu',
      '/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMeterDisk.menu',
      '/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMeterMem.menu',
      '/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMeterCPU.menu',
      '/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuCracker.menu'
      )
      File.open(plist_file, "w") do |plist_handle|
        plist_handle.puts Plist::Emit.dump(ui_plist)
      end
    end
    # long path because this command runs as root, and we're in node['current_user']'s preferences, not root's
    not_if "defaults read ~#{node['current_user']}/Library/Preferences/com.apple.systemuiserver menuExtras | grep 'MenuMeters.prefPane'"
  end

  # My preferences: more history graphs.  Delete this stanza if you want to go with the defaults.
  plist_path = File.expand_path('com.ragingmenace.MenuMeters.plist', File.join(node['sprout']['home'], 'Library', 'Preferences'))
  template plist_path do
    source "com.ragingmenace.MenuMeters.plist.erb"
    owner node['current_user']
  end

  execute "Restart SystemUIServer" do
    command 'killall -HUP SystemUIServer'
    user node['current_user']
    ignore_failure true # SystemUIServer is not running if not logged in
  end

  ruby_block "test to see if MenuMeters was installed" do
    block do
      raise "MenuMeters install failed" unless File.exists?(menu_meters_dst)
    end
  end
end

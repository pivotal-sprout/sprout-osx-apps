require 'json'
require 'mixlib/shellout'

module Plist

  def get_plist_version(app,version_attribute='CFBundleShortVersionString')
    plist = Mixlib::ShellOut.new("plutil -convert  json -r -o -  /Applications/#{app}/Contents/Info.plist")
    plist.run_command

    plist_json = JSON.parse(plist.stdout)

    return plist_json[version_attribute]
  end

end

class Chef::Recipe
  include Plist
end

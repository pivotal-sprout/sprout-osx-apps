require 'net/http'
require 'uri'

app_properties = node['sprout']['iterm2']['app']
dmg_properties = node['sprout']['iterm2']['dmg']

def fetch_http_url(url)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  if uri.scheme == 'https'
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  response = http.request(Net::HTTP::Get.new(uri.path))
  response.body
end

def get_color_schemes
  color_schemes = {}
  node['sprout']['iterm2']['color']['custom_urls'].each do |url|
    filename = URI.decode(URI(url).path.split('/').last)
    scheme_name = File.basename(filename, '.itermcolors')
    scheme_xml = Plist::parse_xml(fetch_http_url(url))
    color_schemes[scheme_name] = Plist::Emit.dump(scheme_xml, false)
  end
  color_schemes
end

gem_package("plist")

unless File.exists?(app_properties['path'])
  remote_file "#{Chef::Config[:file_cache_path]}/iTerm2.zip" do
    source dmg_properties['source']
    checksum dmg_properties['checksum']
    owner node['current_user']
  end

  execute "unzip iterm2" do
    command "unzip #{Chef::Config[:file_cache_path]}/iTerm2.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "move iterm2 to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/iTerm.app #{Regexp.escape(app_properties['path'])}"
    user node['current_user']
    group "admin"
  end

  color_schemes = get_color_schemes
  template "/Users/#{node['current_user']}/Library/Preferences/com.googlecode.iterm2.plist" do
    source "com.googlecode.iterm2.plist.erb"
    user node['current_user']
    mode "0600"
    variables({
      :color_schemes => color_schemes
    })
  end
end

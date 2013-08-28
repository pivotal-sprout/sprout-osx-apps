require 'shellwords'

action :write do
  execute "#{new_resource.description} - #{new_resource.domain} - #{new_resource.key}"  do
    command "defaults write #{new_resource.domain} #{key} #{type_flag} #{value}"
    user node['current_user']
    not_if "defaults read #{new_resource.domain} #{new_resource.key} | grep ^#{value}$"
  end
end

def type_flag
  return '-int' if new_resource.integer
  return '-string' if new_resource.string
  return '-float' if new_resource.float
  return '-boolean' unless new_resource.boolean.nil?
  ''
end

def key
  Shellwords.escape(new_resource.key)
end

def value
  new_resource.integer ||
    new_resource.string && Shellwords.escape(new_resource.string) ||
    (new_resource.float && new_resource.float.to_f) ||
    new_resource.boolean
end

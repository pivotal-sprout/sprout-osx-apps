action :create do
  script_name = ::File.basename(new_resource.name)
  bash_it_custom_lib_dir = ::File.join(node['bash_it']['dir'], "lib")

  template ::File.expand_path(script_name, bash_it_custom_lib_dir) do
    source new_resource.name
    owner node['current_user']
    only_if { script_name =~ /\.bash$/ && ::File.directory?(bash_it_custom_lib_dir) }
    cookbook new_resource.cookbook
  end
end

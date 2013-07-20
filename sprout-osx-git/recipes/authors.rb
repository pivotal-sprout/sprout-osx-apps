# Manage a .git-authors file as expected by https://github.com/modcloth/git-duet

template "#{node['sprout']['home']}/.git-authors" do
  owner node['current_user']
  source "authors.yml.erb"
end

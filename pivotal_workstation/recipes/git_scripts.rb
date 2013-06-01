include_recipe "pivotal_workstation::user_owns_usr_local"

execute "put git-scripts in /usr/local/bin" do
  command "cd /usr/local/bin && curl -L http://github.com/pivotal/git_scripts/tarball/master | gunzip | tar xvf - --strip=2"
  user node['current_user']
  not_if "which git-pair"
end

template "#{node['sprout']['home']}/.pairs" do
  owner node['current_user']
  source "git_scripts_pairs.erb"
end

ruby_block "test that git pair works" do
  block do
    raise "git pair doesn't work" if `which git-pair`.empty?
  end
end


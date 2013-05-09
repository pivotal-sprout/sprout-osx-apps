unless File.exists?("/Applications/Flowdock.app")

    remote_file "#{Chef::Config[:file_cache_path]}/flowdock.zip" do
        source "https://d2ph5hv9wbwvla.cloudfront.net/mac/Flowdock_v1_0_10.zip"
        checksum "fa3d3b05a9a6dd2f359b8ff005baa32b9a99e5139fb19573b3ec2f75e7de496f"
        owner node['current_user']
    end

    execute "unzip flowdock" do
        command "unzip #{Chef::Config[:file_cache_path]}/flowdock.zip -d #{Chef::Config[:file_cache_path]}/"
        user node['current_user']
    end

    execute "copy flowdock to /Applications" do
        command "mv #{Chef::Config[:file_cache_path]}/Flowdock.app #{Regexp.escape("/Applications/Flowdock.app")}"
        user node['current_user']
        group "admin"
    end

    ruby_block "test to see if Flowdock.app was installed" do
        block do
            raise "Flowdock.app was not installed" unless File.exists?("/Applications/Flowdock.app")
        end
    end

end

raise "sudo to root before running" if ENV['SUDO_USER'].nil?
raise "should not be root" if ENV['SUDO_USER'].strip == "root"

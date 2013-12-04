# Sprout Cookbook Conventions

Listed below is list of conventions that all Sprout cookbooks should adhere to unless there are practical 
reasons this isn't possible.

The hope is that following a common set of conventions will make Sprout more accessible to all the developers
that contribute to it and make it easier to notice and then correct things that are out of place.

1. FoodCritic

  Cookbooks should be FoodCritic friendly, ideally with no exceptions to its rules

2. metadata.rb

  Should resemble the snippet below as closely as practical:

    ```
    name             "sprout-example"
    maintainer       "Pivotal"
    maintainer_email "accounts+sprout@pivotallabs.com"
    license          "MIT"
    description      "A brief, and most importantly, accurate description of why the cookbook exists"
    long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
    version          "0.1.0"
    depends          "some-other-sprout-cookbook"
    depends          "some-community-cookbook"
    ```

3. .ruby-version
  
  `system`
  
  All Sprout cookbooks should work with OSX's system ruby and should convey this via a .ruby-version file.

4. .travis.yml

  All Sprout cookbooks should contain a .travis.yml which run FoodCritic at a minimum, but ideally also some
  specs. This will make reviewing pull requests much easier.

5. Vagrantfile

  It's tremendously useful when testing recipes to do this a Vagrant VM, use the template below to create one:
  
  ```
  Vagrant.configure('2') do |config|
    config.vm.box = 'mavericks'
  
    config.vm.provider 'vmware_fusion' do |v|
      v.vmx['ethernet0.virtualDev'] = 'e1000' # Fix networking: https://groups.google.com/d/msg/vagrant-up/VyZBqzbVzvs/GzWECRRuSxgJ
  
      v.gui = true
      v.vmx['memsize'] = '2048'
      v.vmx['numvcpus'] = '1'
      v.vmx['displayName'] = 'Vagrant OSX'
    end
  
    config.vm.provision :shell, inline: <<-BASH
     ruby -v
     cd /vagrant
     sudo gem install bundler --no-ri --no-rdoc
     sudo bundle
     soloist
    BASH
  end
  ```
  
6. Specs

  At Pivotal, we believe maintaining code is made infinitely easier with automated testing. For Sprout 
  cookboks we recommend a combination of [ServerSpec](http://serverspec.org/) and [ChefSpec](https://github.com/sethvargo/chefspec).

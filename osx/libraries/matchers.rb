if defined?(ChefSpec)

  #
  # Assert that an +osx_defaults+ resource exists in the Chef run with the
  # action +:write+. Given a Chef Recipe that writes 12.34 to the key 'baz'
  # on the com.domain.foo domain:
  #
  #     osx_defaults 'update the bar key' do
  #       action :write
  #       domain 'com.domain.foo'
  #       key 'bar'
  #       float 12.34
  #     end
  #
  # The Examples section demonstrates the different ways to test a
  # +osx_defaults+ resource with ChefSpec.
  #
  # @example Assert that a +osx_defaults+ was written
  #   expect(chef_run).to write_osx_defaults('com.domain.foo', 'bar')
  #
  # @example Assert that a +osx_defaults+ was written with predicate matchers
  #   expect(chef_run).to write_osx_defaults('com.domain.foo', 'bar').with_float(12.34)
  #
  # @example Assert that a +osx_defaults+ was written with attributes
  #   expect(chef_run).to write_osx_defaults('com.domain.foo', 'bar').with(float: 12.34)
  #
  #
  # @param [String] domain to update
  #   the domain of the resource to match
  # @param [String] key to update
  #   the key of the resource to match
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def write_osx_defaults(domain, key)
    ChefSpec::Matchers::ResourceMatcher.new(:osx_defaults, :write, //).with(domain: domain, key: key)
  end
end

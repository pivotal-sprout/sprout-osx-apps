require 'spec_helper'

describe command('uname') do
  it { should return_stdout 'Darwin' }
end

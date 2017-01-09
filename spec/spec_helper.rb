require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  if ENV['FUTURE_PARSER'] == 'yes'
    c.parser = 'future'
  end

  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end

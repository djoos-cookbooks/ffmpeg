require 'chefspec'
require 'chefspec/berkshelf'

Dir['libraries/*.rb'].each { |f| require File.expand_path(f) }

at_exit { ChefSpec::Coverage.report! }

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
end

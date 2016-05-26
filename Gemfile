source 'https://rubygems.org'

gem 'rake'

group :lint do
  gem 'rubocop'
  gem 'foodcritic'
end

group :unit, :integration do
  gem 'berkshelf'
end

group :unit do
  gem 'chefspec'
  gem 'rspec-expectations'
end

group :integration do
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'serverspec'
end

# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name        = 'active_admin_basic_authorization_adapter'
  gem.version     = '0.1.0'
  gem.summary     = 'An unofficial and badly tested Basic active admin authorization'
  gem.description = 'Warning, this gem is just a test for now has not a good test coverage.
  Feel free to open an issue for any problem, and please wait for a stable version before any integration.
  And it is a simple gem to handle authorizations for active admin'
  gem.authors     = ['Rémi Wallaere']
  gem.email       = 'remi.wallaere02200@hotmail.fr'
  gem.files       = ['lib/active_admin_basic_authorization_adapter.rb',
                     'lib/generators/basic_admin_authorization/authorization/authorization_generator.rb',
                     'lib/generators/basic_admin_authorization/authorization/USAGE',
                     'lib/generators/basic_admin_authorization/default_authorization/default_authorization_generator.rb',
                     'lib/generators/basic_admin_authorization/default_authorization/USAGE']
  gem.homepage = 'https://github.com/remi-www/active_admin_basic_authorization_adpater'
  gem.license = 'MIT'

  gem.metadata['rubygems_mfa_required'] = 'true'
  gem.required_ruby_version = '>= 2.7.5'

  gem.add_dependency 'activeadmin', '>=2.13.0'
  gem.add_dependency 'pundit', '~> 2.2'
  gem.add_development_dependency 'activemodel', '>= 3.0.0'
  gem.add_development_dependency 'pry', '~> 0.14.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubocop', '1.24.0'
  gem.add_development_dependency 'rubocop-rspec', '2.0.0'
end

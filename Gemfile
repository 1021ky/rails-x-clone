source 'https://rubygems.org'

ruby '3.3.2'

gem 'active_model_serializers'
gem 'annotate'
gem 'bcrypt', '~> 3.1.7'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.7', '>= 6.1.7.8'
gem 'redis', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

gem 'dotenv-rails'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'base64' # for rubocop
  gem 'bigdecimal' # for rubocop
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'debase', '0.2.5.beta2' # https://github.com/ruby-debug/debase/issues/108
  gem 'debug'
  gem 'factory_bot'
  gem 'listen', '~> 3.3'
  gem 'mutex_m' # for rubocop
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rdbg' # bundle binstub debugでbin/rdbgが作られる
  gem 'rspec-core'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'ruby-debug-ide'
  gem 'ruby-lsp'
  gem 'spring'
  gem 'stringio'
  gem 'web-console', '>= 4.1.0'
  gem 'webrick' # for dbmigrate
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

# gem "bcrypt", "~> 3.1.7"
# gem "redis", "~> 4.0"
gem "bootsnap", ">= 1.4.4", require: false
gem "cssbundling-rails", ">= 0.1.0"
gem "devise", git: 'https://github.com/heartcombo/devise.git', branch: 'main'
gem "haml-rails"
gem "jsbundling-rails", "~> 0.1.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.0.alpha2"
gem "stimulus-rails", ">= 0.4.0"
gem "turbo-rails", ">= 0.7.11"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "view_component"

group :development, :test do
  gem "debug", ">= 1.0.0", platforms: %i[ mri mingw x64_mingw ]
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-minitest"
end

group :development do
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

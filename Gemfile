# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

group :development, :test do
  gem 'bundler-audit', '~> 0.9'
  gem 'debug', platforms: %i[mri mingw x64_mingw] # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'rubocop', '~> 1.56'
end

group :test do
  gem 'rspec', '~> 3.12'
end

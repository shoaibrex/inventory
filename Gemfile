source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.8.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'devise'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'pg'
gem 'escpos'
gem "select2-rails"
#gem 'popper_js', '~> 2.9.3'

group :development, :test do
  gem 'byebug', platform: :mri
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'
  gem 'capistrano-bundler'
  gem 'capistrano3-puma'
end
gem "capistrano-secrets-yml"

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'figaro'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

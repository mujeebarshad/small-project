# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "bootsnap", ">= 1.1.0", require: false
gem "clearance", "~> 2.5"
gem "components", git: "https://github.com/jensljungblad/components.git",
                  ref: "ac97cd60b1567eb997aaebaf021dd289c8dc56dd"
gem "jbuilder", "~> 2.5"
gem "puma", "~> 5.6"
gem "pundit", "~> 1.1.0"
gem "rails", "~> 6.0.0"
gem "rolify", "~> 5.2.0"
gem "sass-rails", "~> 5.0"
gem "seedbank"
gem "sqlite3"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "webpacker", "~> 5.2"
gem "will_paginate", "~> 3.1"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "pry"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", "0.82"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

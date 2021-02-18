# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Basic ruby helpers, should you want them
gem "activesupport"

# Database
gem "activerecord"
gem "sqlite3"

# Tests
gem "rspec"
gem "factory_bot"
gem "simplecov", require: false

# Static analysis
gem "rubocop", require: false
gem "rubocop-airbnb", github: "recitalsoftware/ruby",
                      glob: "rubocop-airbnb/rubocop-airbnb.gemspec",
                      require: false
gem "rubocop-rspec", require: false

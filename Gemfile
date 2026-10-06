source "https://rubygems.org"

ruby "3.3.11"

gem "rails", "~> 8.0.0"
gem "pg", "~> 1.7"
gem "puma", ">= 5.0"
gem "bcrypt", "~> 3.1"
gem "csv", "~> 3.3"
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[
  mswin mingw x64_mingw jruby
]

group :development, :test do
  gem "debug", platforms: %i[ mri mswin mingw x64_mingw ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

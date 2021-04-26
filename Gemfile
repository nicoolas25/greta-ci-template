source "https://rubygems.org"

gem "puma"    # web application server
gem "sinatra" # micro web-framework
gem "markaby" # templating library

group :development do
  gem "thor" # Local task runner
end

group :test do
  gem "minitest"           # Test framework
  gem "minitest-reporters" # Reporters for the CI
  gem "rack-test"          # Test helpers for Rack-based app (includes Sinatra)
  gem "nokogiri"           # Parse HTML to test its content
end

ruby "3.0.1"

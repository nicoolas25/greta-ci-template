require "minitest/spec"
require "minitest/reporters"

require "nokogiri" # Parse HTML
require "rack/test" # Give helpers to make requests to Calculator::App

require_relative "../calculator"

# Use export MINITEST_REPORTER=JUnitReporter on the CI
Minitest::Reporters.use!

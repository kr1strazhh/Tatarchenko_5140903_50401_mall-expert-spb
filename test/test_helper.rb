ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

if Gem.loaded_specs["minitest"] && Gem::Version.new(Gem.loaded_specs["minitest"].version) >= Gem::Version.new("6.0.0")
  module Rails
    module LineFiltering
      def run(*args, &block)
        super(*args, &block)
      end
    end
  end
end

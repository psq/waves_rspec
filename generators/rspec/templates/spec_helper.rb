# This file is copied to ~/spec when you run 'rake generate:rspec' from the project root directory.

if File.exist?(waves_src = File.join(File.dirname(__FILE__), '..', 'waves'))
  $:.unshift(File.join(waves_src, 'lib'))
end

ENV["mode"] = "test"
require 'rubygems'
require 'waves'
require 'spec'
Waves::Console.load

require File.join(File.dirname(__FILE__), "..", "configurations", "test")

Spec::Runner.configure do |config|
  # config.something = value

  # Does this work?
  # You can declare fixtures for each behaviour like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so here, like so ...
  #
  #   config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
end

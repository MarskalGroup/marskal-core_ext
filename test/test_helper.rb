$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'marskal/core_ext'
require 'minitest/autorun'
require "minitest/reporters"
require "support_files/custom_expectations"

module TestHelper
  GOT = 0
  EXPECTED = 1
end





# Minitest::Reporters.use!
#
# # Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, Minitest::Reporters::JUnitReporter.new, Minitest::Reporters::RubyMineReporter.new]
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(color: true)]

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'support_files/custom_expectations'
require 'support_files/marskal_testing_utils'



module TestHelper
  GOT = 0
  EXPECTED = 1
  I18N_EN_FILE = 'test/support_files/en.yml'
end



begin
  require 'minitest/reporters'
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(color: true)]
rescue LoadError
  puts '*************************************************'
  puts '*                                               *'
  puts '* We Recommend using the minitest-reporters gem.*'
  puts '* However, it is not required.                  *'
  puts '*                                               *'
  puts '*************************************************'
end
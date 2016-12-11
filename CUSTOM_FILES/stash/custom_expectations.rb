# See: http://chriskottom.com/blog/2014/08/customize-minitest-assertions-and-expectations/
# require 'minitest/spec'
# require 'minitest/assertions'
#
#
#
#
#   end
# # end
#
#
#
# module Minitest::Assertions
#   GOT = 0
#   EXPECTED = 1
#
#
#   #
#   #  Fails unless +expected and +actual have the same items.
#   #
#   def assert_return_whats_expected(p_value_array)
#     assert return_whats_expected(expected),
#            "Expected #{ expected.inspect } and #{ actual.inspect } to have the same items"
#   end
#
#   #
#   #  Fails if +expected and +actual have the same items.
#   #
#   def refute_return_whats_expected(p_value_array)
#     refute return_whats_expected(expected, actual),
#            "Expected #{ expected.inspect } and #{ actual.inspect } would not have the same items"
#   end
#
#   private
#
#   def return_whats_expected(p_value_array)
#     assert_equal p_value_array[GOT],  p_value_array[EXPECTED]
#   end
#
# end
#
# module Minitest::Expectations
#   #
#   #  Fails unless the subject and parameter have the same items
#   #
#   Enumerable.infect_an_assertion :return_whats_expected, :must_return_whats_expected
#
#   #
#   #  Fails if the subject and parameter have the same items
#   #
#   Enumerable.infect_an_assertion :refute_return_whats_expected, :wont_return_whats_expected
# end
require 'minitest/spec'
require 'minitest/assertions'

##
# This module contains custom assertion and expectation to the Minitest module
#
# ==== History
# * <tt>Created: 2016-12-11</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
module Minitest::Assertions

  # Asserts that the string must have either a [ in front or a ] in back
  def assert_has_start_or_end_brackets(p_message=nil, p_value)
    p_message ||= "Expected result would have front or end brackets, but result was:  ==> #{p_value}"
    assert has_start_or_end_brackets(p_value), p_message
  end

  # Refutes that the string must have either a [ in front or a ] in back
  def refute_has_start_or_end_brackets(p_collection, p_value, p_message=nil)
    p_message ||= "Expected result would NOT have front or end brackets, but result was:  ==> #{p_value}"
    assert !has_start_or_end_brackets(p_value), p_message
  end

  # Asserts that the value must be either a TrueClass or a FalseClass
  def assert_is_boolean(p_message=nil, p_value)
    p_message ||= "Expected result should be true or false, but result was:  ==> #{p_value}"
    assert is_boolean(p_value), p_message
  end

  # Refutes that the value must be either a TrueClass or a FalseClass
  def refute_is_boolean(p_collection, p_value, p_message=nil)
    p_message ||= "Expected result should NOT be true or false, but result was:  ==> #{p_value}"
    assert !is_boolean(p_value), p_message
  end


  private

  ##
  # Checks if a string has either a '[' in front or a ']' in back
  # ==== History
  # * <tt>Created: 2016-12-11</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
  #
  # ==== Params
  # * <tt>p_value(String):</tt> This is the string to validate
  #
  # ==== Returns
  # <tt>(Boolean)</tt> true if brackets do exist at front or back false if not
  #
  # ==== Examples
  #   has_start_or_end_brackets('[me]')       #=> true
  #   has_start_or_end_brackets('[xxxxxx')    #=> true
  #   has_start_or_end_brackets('ssss]')      #=> true
  #   has_start_or_end_brackets('ssss')       #=> false
  # ---
  def has_start_or_end_brackets(p_value)  #:doc:
    (p_value[0] == '[' || p_value[-1] == ']')
  end

  ##
  # Checks if the parameter is either a TrueClass or a FalseClass
  #
  # ==== History
  # * <tt>Created: 2016-12-11</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
  #
  # ==== Params
  # * <tt>p_value(Object):</tt> The object variable to validate
  #
  # ==== Returns
  # <tt>(Boolean)</tt> true either +TrueClass+ or +FalseClass+
  #
  # ==== Examples
  #   is_boolean(true)  #=> true
  #   is_boolean(false) #=> true
  #   is_boolean('ddd') #=> false
  #   is_boolean(1)     #=> false
  # ---
  def is_boolean(p_value) #:doc:
    (p_value.is_a?(TrueClass) || p_value.is_a?(FalseClass))
  end


end

# set expectation to infect a coresponding assertion
module Minitest::Expectations
  infect_an_assertion :assert_has_start_or_end_brackets, :must_have_start_or_end_brackets
  infect_an_assertion :refute_has_start_or_end_brackets, :wont_have_start_or_end_brackets
  infect_an_assertion :assert_is_boolean, :must_be_boolean
  infect_an_assertion :refute_is_boolean, :wont_be_boolean
end
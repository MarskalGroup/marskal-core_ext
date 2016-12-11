require 'minitest/spec'
require 'minitest/assertions'

module Minitest::Assertions

  #
  #  Fails unless +expected and +actual have the same items.
  #
  def assert_has_start_or_end_brackets
    assert has_start_or_end_brackets,
           "Expected result would have front or end brackets, but result was:  ==> #{self}"
  end

  #
  #  Fails if +expected and +actual have the same items.
  #
  def refute_has_start_or_end_brackets
    refute has_start_or_end_brackets,
           "Expected result would NOT have front or end brackets, but result was:  ==> #{self}"
  end

  private

    def has_start_or_end_brackets
      (self[0] == '[' || self[-1] == ']') || false
    end

end

module Minitest::Expectations
  #
  #  Fails unless the subject and parameter have the same items
  #
  Enumerable.infect_an_assertion :has_start_or_end_brackets, :must_have_start_or_end_brackets

  #
  #  Fails if the subject and parameter have the same items
  #
  Enumerable.infect_an_assertion :refute_has_start_or_end_brackets, :wont_have_start_or_end_brackets
end
require 'test_helper'

##
# This Section Tests all the Marskal::CoreExt::MyHash +Hash+ extensions
#
# ==== History
# * <tt>Created: 2016-10-2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
# ---
describe 'Tests for Marskal::CoreExt::MyHash' do

  describe 'Tests Instance method => assert_require_keys' do

    it 'Must return true if a the hash object contains all teh required keys' do
      {lastname: 'jones', firstname: 'tim'}.assert_require_keys(:firstname, :lastname).must_equal true
    end

    it 'Must raise an error if required keys are missing' do
      proc {{lastname: 'jones', nickname: 'tim'}.assert_require_keys(:firstname, :lastname, :birthday) }.must_raise ArgumentError
    end

  end


end



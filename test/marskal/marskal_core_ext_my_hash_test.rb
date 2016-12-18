require 'test_helper'
require 'marskal/core_ext/hash'

##
# This Section Tests all the Marskal::CoreExt::MyHash +Hash+ extensions
#
# ==== History
# * <tt>Created: 2016-12-10</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
# ---
describe 'Marskal::CoreExt::MyHash' do

  describe 'Tests Instance method => provide_default' do

    it 'Return self is key exists ' do
      {color: 'Red'}.provide_default(:color, 'White').must_equal 'Red'
    end

    it 'Return default is key does NOT exist ' do
      {color: 'Red'}.provide_default(:size, 'Medium').must_equal 'Medium'
    end

  end

  describe 'Tests Instance method => blank?' do

    it 'Return true if Hash is empty' do
      {}.blank?.must_equal true
    end

    it 'Return false if Hash is NOT empty' do
      {item1: 'not empty'}.blank?.must_equal false
    end


  end


  describe 'Tests Instance method => assert_require_keys' do

    it 'Return true if Hash contains all the required keys' do
      {lastname: 'jones', firstname: 'tim'}.assert_require_keys(:firstname, :lastname).must_equal true
    end

    it 'Must raise an error if required keys are missing' do
      proc {{lastname: 'jones', nickname: 'tim'}.assert_require_keys(:firstname, :lastname, :birthday) }.must_raise ArgumentError
    end

  end

end



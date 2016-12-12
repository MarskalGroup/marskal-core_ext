require 'test_helper'

##
# This Section Tests all the Marskal::CoreExt::MyFile +File+ extensions
#
# ==== History
# * <tt>Created: 2016-10-2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
# ---
describe 'Marskal::CoreExt::MyFile' do
  ##
  # Prepare variables for testing
  #
  # ==== History
  # * <tt>Created: 2016-10-2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
  #
  # ==== Variables
  # * <tt>@good_result(Boolean):</tt> The value is true
  # * <tt>@bad_result(Boolean):</tt> The value is false
  # ---
  before do
    Marskal::Testing::Utils.silence_output
    @good_result = File.markdown_to_text('README.md') #file exists
    @bad_result =  File.markdown_to_text('GARBAGE.md') #file does not exist
  end

  ##
  # After tests are done, we can re-enable the stdout(puts) output
  #
  # ==== History
  # * <tt>Created: 2016-10-2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
  # ---
  after do
    Marskal::Testing::Utils.enable_output
  end

  describe 'Tests Class method => File.markdown_to_text' do

    it 'Must return true if a valid file' do
      @bad_result.must_equal false
    end

    it 'Must return false if a missing file' do
      @good_result.must_equal true
    end


  end


end



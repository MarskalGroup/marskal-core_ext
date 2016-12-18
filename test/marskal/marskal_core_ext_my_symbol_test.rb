require 'test_helper'
require 'marskal/core_ext/symbol'


##
# This Section Tests all the Marskal::CoreExt::MySymbol +Symbol+ extensions
#
# ==== History
# * <tt>Created: 2016-12-17</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
# ---
describe 'Marskal::CoreExt::MySymbol' do

  describe 'Tests Instance method =>  to_h' do

    it 'Must Return a Hash object' do
      :field1.to_h.must_be_kind_of Hash
    end

    it 'Must return expected result' do
      :field1.to_h.must_equal({ field1: nil})
    end

  end


end



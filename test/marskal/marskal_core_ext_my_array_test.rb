require 'test_helper'
require 'marskal/core_ext/array'

##
# This Section Tests all the Marskal::CoreExt +Array+ extensions
#
# ==== History
# * <tt>Created: 2016-12-10</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
# ---
describe 'Marskal::CoreExt::MyArray' do

  ##
  # Prepare variables for testing
  #
  # ==== History
  # * <tt>Created: 2016-12-10</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
  #
  # ==== Variables
  # * <tt>@got(Array):</tt> Equal to 0, the index to the array element containing the result of the method call
  # * <tt>@expected(Array):</tt> Equal to 1, the index to the array element containing the expected result
  # * <tt>@ary(Array):</tt> An array to use for testing
  # * <tt>@@field_array(Array):</tt> An array to use for testing SQL field related methods like <tt>sql_null_to_blank</tt>
  # * <tt>@results(Hash)</tt> Stores the _@got_ and _@expected_ values for each method
  #   * The first element is the value returned by the method
  #   * The second element is the value @expected
  # ---
  before do
    @got = TestHelper::GOT
    @expected = TestHelper::EXPECTED
    @ary = ['hello','bye','yo','whats up']
    @field_array = ['fld1', 'fld2', 'fld3']
    @results = {
        no_brackets: [@ary.to_string_no_brackets, "\"hello\", \"bye\", \"yo\", \"whats up\""],
        no_brackets_or_quotes: [@ary.to_string_no_brackets_or_quotes, "hello, bye, yo, whats up"],
        prepare_for_sql_in_clause: [@ary.prepare_for_sql_in_clause, "(\"hello\", \"bye\", \"yo\", \"whats up\")"],
        json_data_for_highcharts: [@ary.json_data_for_highcharts, "[hello,bye,yo,whats up]"],
        sql_null_to_blank: [@field_array.sql_null_to_blank, ["IFNULL(fld1, '')", "IFNULL(fld2, '')", "IFNULL(fld3, '')"]],
    }
  end

  describe 'Tests Instance method => sort_and_include_index' do
    it 'Return Empty Array if Array was passed as empty' do
      [].sort_and_include_index.must_be_empty
    end

    it 'Returns expected when passed integer array' do
      [3,2,1].sort_and_include_index.must_equal [[1, 2], [2, 1], [3, 0]]
    end

    it 'Returns expected when passed integer array in reverse' do
      [3,2,1].sort_and_include_index.reverse.must_equal [[3, 0], [2, 1], [1, 2]]
    end

    it 'Returns expected when passed string array' do
      %w(B D A C).sort_and_include_index.must_equal [["A", 2], ["B", 0], ["C", 3], ["D", 1]]
    end

    it 'Returns expected when passed string array in reverse' do
      %w(B D A C).sort_and_include_index.reverse.must_equal [["D", 1], ["C", 3], ["B", 0], ["A", 2]]
    end

  end

  describe 'Tests Instance method => blank?' do

    it 'Return true if Array is empty' do
      [].blank?.must_equal true
    end

    it 'Return false if Array is NOT empty' do
      [1,2,3].blank?.must_equal false
    end
  end

  describe 'Tests method => to_string_no_brackets' do

    it 'Returns expected result' do
      @results[:no_brackets][@got].must_equal "#{@results[:no_brackets][@expected]}"
    end

    it 'Must Return a String' do
      @results[:no_brackets][@got].must_be_instance_of String
    end

    it 'Wont have start or end brackets.' do
      @results[:no_brackets][@got].wont_have_start_or_end_brackets
    end

    it 'Must return string with proper length' do
      #remove 2 characters length from end to accommodate brackets being removed
      @results[:no_brackets][@got].length.must_equal (@ary.to_s.length - 2),
          "Result[Len: #{@results[:no_brackets][@got].length}] should be 2 characters less than original array to string[Len: #{@ary.to_s.length}]"
    end

  end

  describe 'Tests method => no_brackets_or_quotes' do

    it 'Returns expected result' do
      @results[:no_brackets_or_quotes][@got].must_equal "#{@results[:no_brackets_or_quotes][@expected]}"
    end

    it 'Must Return a String' do
      @results[:no_brackets_or_quotes][@got].must_be_instance_of String
    end

    it 'Wont have start or end brackets.' do
      @results[:no_brackets_or_quotes][@got].wont_have_start_or_end_brackets
    end

    it 'Must return string with proper length' do
      # @expected length will account for quotes and brackets that will be erased in this example
      l_expected_length = @ary.to_s.length - (@ary.to_s.count("'") + 2)
      @results[:no_brackets][@got].length.must_equal l_expected_length
    end

  end

  describe 'Tests method => prepare_for_sql_in_clause' do

    it 'Returns expected result' do
      @results[:prepare_for_sql_in_clause][@got].must_equal "#{@results[:prepare_for_sql_in_clause][@expected]}"
    end

    it 'Must Return a String' do
      @results[:prepare_for_sql_in_clause][@got].must_be_instance_of String
    end

    it "Must have be contained by '(\"\")' for String Arrays." do
      l_start_and_end_str = "#{@results[:prepare_for_sql_in_clause][@got][0..1]}#{@results[:prepare_for_sql_in_clause][@got][-2..-1]}"
      l_start_and_end_str.must_equal '("")', "@expected parentheses around result, but result was:  ==> #{@results[:prepare_for_sql_in_clause][@got]}"
    end

    it 'Must return proper number of elements' do
      @results[:prepare_for_sql_in_clause][@got].split(',').length.must_equal @ary.length
    end
  end

  describe 'Tests method => json_data_for_highcharts' do

    it 'Returns expected result' do
      @results[:json_data_for_highcharts][@got].must_equal "#{@results[:json_data_for_highcharts][@expected]}"
    end

    it 'Must Return a String' do
      @results[:json_data_for_highcharts][@got].must_be_instance_of String
    end

    it 'Must have be contained by brackets.' do
      @results[:json_data_for_highcharts][@got].must_have_start_or_end_brackets
    end

    it 'Must return proper number of elements' do
      @results[:json_data_for_highcharts][@got].split(',').length.must_equal @ary.length
    end

    it 'Wont contain any double quotes' do
      @results[:json_data_for_highcharts][@got].wont_include('""')
    end
  end

  describe 'Tests method => sql_null_to_blank' do

    it 'Returns expected result' do
      @results[:sql_null_to_blank][@got].must_equal @results[:sql_null_to_blank][@expected]
    end

    it 'Must Return an Array' do
      @results[:sql_null_to_blank][@got].must_be_instance_of Array
    end

    it 'Must return proper number of elements' do
      @results[:sql_null_to_blank][@got].length.must_equal @field_array.length
    end

    it "Each Element must be surrounded by 'IFNULL(, '')'." do
      @results[:sql_null_to_blank][@got].must_equal @results[:sql_null_to_blank][@expected].keep_if { |a| "#{a[0,7]}#{a.reverse[0,5].reverse}" == "IFNULL(, '')"}
    end

  end


end



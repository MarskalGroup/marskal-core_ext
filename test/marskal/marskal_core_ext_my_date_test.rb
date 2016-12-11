require 'test_helper'

##
# This Section Tests all the Marskal::CoreExt +Date+ extensions
#
# ==== History
# * <tt>Created: 2016-10-2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
# ---
describe 'Tests for Marskal::CoreExt::MyArray' do

  ##
  # Prepare variables for testing
  #
  # ==== History
  # * <tt>Created: 2016-10-2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
  #
  # ==== Variables
  # * <tt>@got(Array):</tt> Equal to 0, the index to the array element containing the result of the method call
  # * <tt>@expected(Array):</tt> Equal to 1, the index to the array element containing the expected result
  # * <tt>@results(Hash)</tt> Stores the _@got_ and _@expected_ values for each method
  #   * The first element is the value returned by the method
  #   * The second element is the value @expected
  # ---
  before do

    ActiveSupport::Deprecation.silenced = true

    @got = TestHelper::GOT
    @expected = TestHelper::EXPECTED
    @monday = 1  # monday is a wday of 1

    @today = Date.today
    @past_date = Date.today - 6.months
    @weekend = '2016-12-11'.to_date
    @results = {
        self_start_of_week: [Date.start_of_week, test_start_of_week(@today)],
        start_of_week: [@past_date.start_of_week, test_start_of_week(@past_date)],
        start_of_month: [@past_date.start_of_month, @past_date.start_of_month],
        beginning_of_next_month: [@past_date.beginning_of_next_month, (@past_date + 1.month).strftime('%Y-%m-01').to_date],
        formatted: [@past_date.formatted, @past_date.strftime('%m/%d/%Y')],
        is_today_weekend?: [Date.is_today_weekend?, test_is_a_weekend?],
        is_weekend?: [@weekend.is_weekend?, true],
        end_of_work_week: [@past_date.end_of_work_week, @past_date.beginning_of_week+4.days],
        for_highcharts: [@past_date.for_highcharts, 1465603200000],
    }
  end

  describe 'Tests Class method => Date.start_of_week' do

    it 'Returns an expected result' do
      @results[:self_start_of_week][@got].must_equal @results[:self_start_of_week][@expected]
    end

    it 'Must Return a Date' do
      @results[:self_start_of_week][@got].must_be_instance_of Date
    end

    it 'Date Returned must be a Monday' do
      @results[:self_start_of_week][@got].wday.must_equal @monday  #Monday is wday of 1
    end

  end

  describe 'Tests Instance method => start_of_week' do

    it 'Returns an expected result' do
      @results[:start_of_week][@got].must_equal @results[:start_of_week][@expected]
    end

    it 'Must Return a Date' do
      @results[:start_of_week][@got].must_be_instance_of Date
    end

    it 'Date Returned must be a Monday' do
      @results[:start_of_week][@got].wday.must_equal @monday  #Monday is wday of 1
    end

  end

  describe 'Tests Instance method => start_of_month' do

    it 'Returns an expected result' do
      @results[:start_of_month][@got].must_equal @results[:start_of_month][@expected]
    end

    it 'Must Return a Date' do
      @results[:start_of_month][@got].must_be_instance_of Date
    end

    it 'Date Returned must the first day of a month' do
      @results[:start_of_month][@got].day.must_equal 1
    end

  end

  describe 'Tests Instance method => beginning_of_next_month' do

    it 'Returns an expected result' do
      @results[:beginning_of_next_month][@got].must_equal @results[:beginning_of_next_month][@expected]
    end

    it 'Must Return a Date' do
      @results[:start_of_month][@got].must_be_instance_of Date
    end

    it 'Date Returned must the first day of a month' do
      @results[:start_of_month][@got].day.must_equal 1
    end

  end

  describe 'Tests Instance method => formatted' do

    it 'Returns an expected result' do
      @results[:formatted][@got].must_equal @results[:formatted][@expected]
    end

    it 'Must Return a String' do
      @results[:formatted][@got].must_be_instance_of String
    end

    it 'Date Returned must have slashes in right places' do
      "#{@results[:formatted][@got][2]}#{@results[:formatted][@got][5]}".must_equal '//'
    end

  end

  describe 'Tests Class method => is_today_weekend?' do

    it 'Returns an expected result' do
      @results[:is_today_weekend?][@got].must_equal @results[:is_today_weekend?][@expected]
    end

    it 'Must return a Boolean value' do
      @results[:is_today_weekend?][@got].must_be_boolean
    end

  end

  describe 'Tests Instance method => is_weekend?' do

    it 'Returns an expected result' do
      @results[:is_weekend?][@got].must_equal @results[:is_weekend?][@expected]
    end

    it 'Must return a Boolean value' do
      @results[:is_weekend?][@got].must_be_boolean
    end

    it 'Must return false if not a weekend' do
      (@weekend - 3.days).is_weekend?.must_equal false
    end

  end

  describe 'Tests Instance method => end_of_work_week' do

    it 'Returns an expected result' do
      @results[:end_of_work_week][@got].must_equal @results[:end_of_work_week][@expected]
    end

    it 'Must return a Date' do
      @results[:end_of_work_week][@got].must_be_instance_of Date
    end

    it 'Must return a Friday Date' do
      @results[:end_of_work_week][@got].friday?.must_equal true
    end

    it 'If weekend, the date should be prior to weekend' do
      @weekend.end_of_work_week.must_be :<, @weekend
    end

  end

  describe 'Tests Instance method => for_highcharts' do

    it 'Returns an expected result' do
      @results[:for_highcharts][@got].must_equal @results[:for_highcharts][@expected]
    end

    it 'Must return an Bignum' do
      @results[:for_highcharts][@got].must_be_instance_of Bignum
    end

  end

  private

  def test_start_of_week(p_date)
    if p_date.wday == 0  #sundays count as end of week for vehicle app
      return p_date - 6
    else
      (p_date - p_date.wday.days) + 1  #start on monday
    end
  end

  def test_is_a_weekend?(p_date = Date.today)
    p_date.saturday? || p_date.sunday?
  end



end



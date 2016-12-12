module Marskal
  module CoreExt

    ##
    # Extends functionality to Ruby's +Date+ class
    #
    # ==== History
    # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    module MyDate

      extend ActiveSupport::Concern

      ##
      # <b>!!!! DEPRECATED: !!!!</b> <br>
      # Use Ruby's +.beginning_of_week+ method instead
      #   "2016-10-02".to_date.beginning_of_week
      #
      # Gets the most recently past Monday Date from the given date.
      # This method should always return a date on a Monday.
      #
      # ==== Extends
      # Extends Ruby's <tt>Date</tt> class
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(Date)</tt> The most recent past Monday date
      #
      # ==== Examples
      #   "2016-10-02".to_date.start_of_week   #=> Mon, 26 Sep 2016
      # ---
      def start_of_week
        Marskal::CoreExt.deprecate_this(:start_of_week, 'use ".beginning_of_week" => "2016-10-02".to_date.beginning_of_week')
        self.beginning_of_week(:monday)
      end

      ##
      # <b>!!!! DEPRECATED: !!!!</b> <br>
      # Use Ruby's +.beginning_of_month+ method instead
      #   "2016-10-02".to_date.beginning_of_month
      #
      # Gets the the first day of the month for the given date.
      # This method should always return a date on th first day of the month
      #
      # ==== Extends
      # Extends Ruby's <tt>Date</tt> class
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(Date)</tt> The beginning of the month given date
      #
      # ==== Examples
      #   "2016-10-12".to_date.start_of_month   #=> Sat, 01 Oct 2016
      # ---
      def start_of_month
        Marskal::CoreExt.deprecate_this(:start_of_month, 'use ".beginning_of_month" => "2016-10-02".to_date.2016-10-12".to_date.start_of_month')
        self.beginning_of_month
      end


      ##
      # <b>!!!! DEPRECATED: !!!!</b> <br>
      # Gets the the first day of the *NEXT* month for the given date.
      # This method should always return a date on the first day of a month
      # Start using the method beginning_of_next_month created in this module. It was renamed
      # to keep more consistent with ruby methods
      #
      # ==== Extends
      # Extends Ruby's <tt>Date</tt> class
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(Date)</tt> The beginning of the *NEXT* month given date
      #
      # ---
      def start_of_next_month
        Marskal::CoreExt.deprecate_this(:start_of_next_month, 'use ".beginning_of_month" => "2016-10-02".to_date.2016-10-12".to_date.start_of_month')
        beginning_of_next_month
      end

      ##
      # Gets the the first day of the *NEXT* month for the given date.
      # This method should always return a date on the first day of a month
      #
      # ==== Extends
      # Extends Ruby's <tt>Date</tt> class
      #
      # ==== History
      # * <tt>Created: 2016-12-11</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(Date)</tt> The beginning of the *NEXT* month of the given date
      #
      # ==== Examples
      #   "2016-10-12".to_date.beginning_of_next_month   #=> Tue, 01 Nov 2016
      # ---
      def beginning_of_next_month
        self.next_month.beginning_of_month
      end


      ##
      # Formats the date and returns a string in the format specified.
      # The default is the american format of *mm/dd/yyyy*.
      # The original idea behind this was just a quick way to format Ruby dates in American format.
      # Otherwise its best to use Ruby +strftime+ directly.
      #
      # ==== Extends
      # Extends Ruby's <tt>Date</tt> class
      #
      # ==== History
      # * <tt>Created:  2010-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      # * <tt>Last Modified: 2016-12-11</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>p_format(String)(_defaults_ to: '%m/%d/%Y' ):</tt> This format that will be passed on to strftime
      #
      # ==== Returns
      # * <tt>(String)</tt> The formatted date
      #
      # ==== Examples
      #   '2016-12-02'.to_date.formatted()            #=> "12/02/2016"
      #   Date.today.formatted()                      #=> "12/11/2016"
      #   '2016-12-02'.to_date.formatted('%Y-%m-%d')  #=> "2016-12-02"
      # ---
      def formatted(p_format = '%m/%d/%Y')
        self.strftime(p_format)
      end

      ##
      # Checks if the given date is a weekend
      #
      # ==== Extends
      # Extends Ruby's <tt>Date</tt> class
      #
      # ==== History
      # * <tt>Created: 2010-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      # * <tt>Last Modified: 2016-12-11</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(Boolean)</tt> true if given date(self) is a weekend
      #
      # ==== Examples
      #   '2016-12-10'.to_date.is_weekend?   #=> true
      #   '2016-10-10'.to_date.is_weekend?   #=> false
      # ---
      def is_weekend?
        self.saturday? || self.sunday?
      end

      ##
      # Gets the friday date of the current week. If Saturday or Sunday, it will get the PREVIOUS friday
      #
      # ==== Extends
      # Extends Ruby's <tt>Date</tt> class
      #
      # ==== History
      # * <tt>>Created: 2016-12-11</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(Date)</tt> The  Friday date of the given date
      #
      # ==== Examples
      #   '2016-12-10'.to_date.end_of_work_week   #=> Fri, 09 Dec 2016
      #   '2016-10-10'.to_date.end_of_work_week   #=> Fri, 14 Oct 2016
      # ---
      def end_of_work_week
        self.beginning_of_week + 4.days
      end

      ##
      # This method formats the date for use in HighCharts json
      # I cant say I understand exactly how this works, but using examples I came up with a method that HighCharts seems to work well with
      #
      # ==== Extends
      # Extends Ruby's <tt>Date</tt> class
      #
      # ==== History
      # * <tt>Created: 2014-05-01</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(Date)</tt> The Date in HighCharts compatible format
      #
      # ==== Examples
      #   '2016-12-10'.to_date.for_highcharts   #=> 1481331600000
      #   '2016-10-10'.to_date.for_highcharts   #=> 1476057600000
      # ---
      def for_highcharts
        "#{(self-1.day).to_time.strftime("%Y-%m-%d 19:00").to_time.utc.to_i}000".to_i
      end


      module ClassMethods

        ##
        # <b>!!!! DEPRECATED: !!!!</b> <br>
        # Use Ruby's +.beginning_of_week+ method instead
        #   Date.today.beginning_of_week
        #
        # Gets the most recent Monday Date from today. This method should always return a date on a Monday
        #
        # ==== Extends
        # Extends Ruby's <tt>Date</tt> class
        #
        # ==== History
        # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
        #
        # ==== Returns
        # * <tt>(Date)</tt> The most recent past Monday date
        #
        # ==== Examples
        #   #Assume Today's Date of '2016-12-10'
        #   Date.start_of_week   #=> Mon, 05 Dec 2016
        #
        # ---
        def start_of_week
          Marskal::CoreExt.deprecate_this(:start_of_week, 'use Rubys ".beginning_of_week" =>Date.today.beginning_of_week')
          Date.today.beginning_of_week(:monday)
        end

        ##
        # <b>!!!! DEPRECATED: !!!!</b> <br> No tests were written for this since it should NOT be used anymore.
        # Use Ruby's +to.date+ method instead
        #   "10/12/1999".to_date
        #
        # converts string formatted as mm/dd/yy or mm/dd/yyyy into a date
        #
        # ==== Extends
        # Extends Ruby's <tt>Date</tt> class
        #
        # ==== History
        # * <tt>Created: 2010-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
        #
        # ==== Returns
        # * <tt>(Date)</tt> The date representation of the string
        #
        # ---
        def create_from_string(p_date_str)
          Marskal::CoreExt.deprecate_this(:create_from_string, 'use ".to_s" => "10/12/1999".to_s')
          parts = p_date_str.split("/")
          return nil if parts.length != 3
          return Date.new(parts[2].to_i,parts[0].to_i,parts[1].to_i)
        end

        ##
        # Checks if the current date is a weekend
        #
        # ==== Extends
        # Extends Ruby's <tt>Date</tt> class
        #
        # ==== History
        # * <tt>Created: 2010-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
        # * <tt>Last Modified: 2016-12-11</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
        #
        # ==== Returns
        # * <tt>(Boolean)</tt> true if current date is a weekend
        #
        # ==== Examples
        #   #Assume Today's Date of '2016-12-10'
        #   Date.is_today_weekend?   #=> true
        #
        #   #Assume Today's Date of '2016-10-10'
        #   Date.is_today_weekend?   #=> false
        # ---
        def is_today_weekend?
          Date.today.saturday? || Date.today.sunday?
        end


      end  #end ClassMethods

    end
  end
end

# now that the module has been built, lets extend Ruby's +Date+ class to accept these methods
Date.send(:include, Marskal::CoreExt::MyDate)




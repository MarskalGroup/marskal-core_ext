module Marskal
  module CoreExt

    ##
    # Extends functionality to Ruby's +Array+ class
    #
    # ==== History
    # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    module MyArray

      extend ActiveSupport::Concern

      ##
      # Converts an Array into a String and removes the surrounding brackets
      #
      # ==== Extends
      # Extends Ruby's  <tt>Array</tt> class
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(String)</tt> The array element as a string without brackets
      #
      # ==== Examples
      #   [1,2,3].to_string_no_brackets                 #=> '1,2,3'
      #   ['one','two','three'].to_string_no_brackets   #=> "\"one\", \"two\", \"three\""
      # ---
      def to_string_no_brackets
        self.to_s.gsub(/[\[\]]/,'')
      end


      ##
      # Converts an Array into a String and removes the surrounding brackets and any quotes that exist
      #
      # ==== Extends
      # Extends Ruby's  <tt>Array</tt> class
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(String)</tt> The array element as a string without brackets or quotes
      #
      # ==== Examples
      #   [1,2,3].to_string_no_brackets_or_quotes                 #=> '1,2,3'
      #   ['one','two','three'].to_string_no_brackets_or_quotes   #=> "one, two, three"
      # ---
      def to_string_no_brackets_or_quotes
        self.to_s.gsub(/[\"\[\]]/,'')
      end

      ##
      # Prepares an array for an mysql based *IN* clause
      #
      # ==== Extends
      # Extends Ruby's  <tt>Array</tt> class
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(String)</tt> The array element as a string ready for use in an sql *IN* clause
      #
      # ==== Examples
      #   [1,2,3,4].prepare_for_sql_in_clause               #=> "(1, 2, 3, 4)"
      #   ['one','two','three'].prepare_for_sql_in_clause   #=> "(\"one\", \"two\", \"three\")"
      # ---
      def prepare_for_sql_in_clause
        "(#{self.to_string_no_brackets})"
      end

      ##
      # This formats json data for use in the high-charts javascript library functions
      #
      # ==== Extends
      # Extends Ruby's  <tt>Array</tt> class
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(String)</tt> The array element as a string ready for use in Highcharts
      #
      # ==== Examples
      #   [1,2,3,4,"1", "rr"].json_data_for_highcharts  #=> "[1,2,3,4,1,rr]"
      # ---
      def json_data_for_highcharts
        # self.to_json.gsub(/[\'\"]/,'')   # Future?: maybe add this as a parameter to include or exclude single quotes
        self.to_json.gsub(/[\"]/,'')       # but for now, we will allow single quotes strings are allowed in json
      end


      ##
      # This method puts an _IFNULL_ around each array element for use in mysql Select statement.
      # The value will be given as empty string if the field is null in a _MYSQL_ select statement
      #
      # ==== Extends
      # Extends Ruby's  <tt>Array</tt> class
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # * <tt>(String)</tt> The array formatted each element with IFNULL ready for use in  MYSQL Select
      #
      # ==== Examples
      #   ['fld1', 'fld2', 'fld3'].sql_null_to_blank    #=> ["IFNULL(fld1, '')", "IFNULL(fld2, '')", "IFNULL(fld3, '')"]
      # ---
      def sql_null_to_blank
        self.map {|v| "IFNULL(#{v}, '')" }
      end


    end
  end
end

# now that the module has been built, lets extend Ruby's +Array+ class to accept these methods
Array.send(:include, Marskal::CoreExt::MyArray)




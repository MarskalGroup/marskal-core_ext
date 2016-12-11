module Marskal
  module CoreExt

    ##
    # Array. Extends functionality to Ruby's +Array+ class
    #
    # ==== History
    # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    module Array
      extend  Marskal::CoreExt::Base
      #DOCME:
      def self.included(base)
        base.extend ClassMethods
      end

      ##
      # Tests to ensure a string does not have *"["* in from or a *"]"* at the end of the string
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Returns
      # <tt>(String)</tt> The Array as a string without brackets
      #
      # ==== Examples
      #   [1,2,3].to_string_no_brackets                 ==> #returns '1,2,3'
      #   ['one','two','three'].to_string_no_brackets   ==> #returns "\"one\", \"two\", \"three\""
      #
      def to_string_no_brackets
        self.to_s.gsub(/[\[\]]/,'')
      end

      #DOCME
      module ClassMethods
        def testme
            puts 'test worked'
        end
      end

    end
  end
end




module Marskal
  module TestSupport
    MYVAR = 999

    def testme1
      100
    end

    def self.testme1
      99
    end
  end
end


def myMod99
  include Marskal::TestSupport
  def one
    puts "==>#{MYVAR}"
  end
end


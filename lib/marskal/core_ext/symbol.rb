module Marskal
  module CoreExt
    ##
    # Extends functionality to Ruby's +Symbol+ class
    #
    # ==== History
    # * <tt>Created: 2016-12-17</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    module MySymbol

      ##
      # This simply converts the symbol into a hash with a value of nil
      #
      # ==== History
      # * <tt>Created: 2016-12-17</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Extends
      # * Extends Ruby's <tt>Symbol</tt> class
      #
      # ==== Params
      # * <tt>self(Object):</tt> The symbol to convert
      #
      # ==== Returns
      # * <tt>(self)(Hash))</tt> returns self as a hash with a nil val
      #
      # ==== Examples
      #   :fld1.to_h        #=>  {:fld1=>nil}
      # ---
      def to_h
        { self => nil }     #make it a Hash
      end
    end
  end
end

# now that the module has been built, lets extend Ruby's +Symbol+ class to accept these methods
Symbol.send(:include, Marskal::CoreExt::MySymbol)




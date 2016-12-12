module Marskal
  module CoreExt

    ##
    # Extends functionality to Ruby's +Hash+ class
    #
    # ==== History
    # * <tt>Created: 2016-12-12</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    module MyHash
      extend ActiveSupport::Concern

      ##
      # This raises an argument error if the given Hash is missing a required key
      #
      # ==== History
      # * <tt>Created: 2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Extends
      # * Extends Ruby's <tt>Hash</tt> class
      #
      # ==== Params
      # * <tt>self(Hash):</tt> self is the hash of key/value pairs to be validated
      # * <tt>*p_required_keys(Array):</tt> Contains the required hash keys
      #
      # ==== Returns
      # * <tt>(Boolean)</tt> Returns true if required keys were provided, otherwise raises an error
      #
      # ==== Examples
      #  {lastname: 'jones', nickname: 'tim'}.assert_require_keys(:firstname, :lastname, :birthday)
      #       # Output ==> ArgumentError: Missing required key(s): :firstname, :birthday
      #
      #  {lastname: 'jones', firstname: 'tim', birthday: '1977-12-22'}.assert_require_keys(:firstname, :lastname, :birthday)
      #       # Returns ==> true
      #
      # ---
      def assert_require_keys(*p_required_keys)

        l_missing_keys = []                             #initialize array
        p_required_keys.flatten!                        #flatten required keys array
        p_required_keys.each do |k|                     #loop through all the required keys
          l_missing_keys << k  unless self.has_key?(k)  #store any keys not found in the hash
        end
    
        #raiise error if any keys are missing
        unless l_missing_keys.empty?
          raise ArgumentError.new("Missing required key(s): #{l_missing_keys.map(&:inspect).join(', ')}")
        end

        true  #return true if all required keys were given
    
      end
      
    end
  end
end

# now that the module has been built, lets extend Ruby's +Hash+ class to accept these methods
Hash.send(:include, Marskal::CoreExt::MyHash)
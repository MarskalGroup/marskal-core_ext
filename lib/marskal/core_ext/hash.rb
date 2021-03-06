module Marskal
  module CoreExt

    ##
    # Extends functionality to Ruby's +Hash+ class
    #
    # ==== History
    # * <tt>Created: 2016-12-12</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    module MyHash

      ##
      # This is a simple method used to add a key to the hash and supply a default *ONLY* if the key does not already
      # exist in the hash.
      #
      # ==== History
      # * <tt>Created: 2016-12-18</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Extends
      # * Extends Ruby's <tt>Hash</tt> class
      #
      # ==== Params
      # * <tt>self(Hash):</tt> self is the Hash will be checking and adding to if needed
      # * <tt>p_key(String or Symbol):</tt> They key to check for
      # * <tt>p_value(Object):</tt> The value to be applied to this key if the key does not exist yet
      #
      # ==== Returns
      # * <tt>(Object)</tt> Returns the value of the hash element identified by key
      #
      # ==== Examples
      #
      #   def order_shirt(options = {})
      #     options.provide_default(:color, 'White')
      #     options.provide_default(:size, 'Medium')
      #     puts "#{options[:color]}, #{options[:size]}"
      #   end
      #
      #   order_shirt()                                 #=> White, Medium
      #   order_shirt(color: 'Red')                     #=> Red, Medium
      #   order_shirt(size: 'Large')                    #=> White, Large
      #   order_shirt(color: 'Red', size: 'Large')      #=> Red, Large
      #
      # ---
      def provide_default(p_key, p_value)
        self[p_key] = p_value unless self.has_key?(p_key)
        self[p_key]
      end

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

      ##
      # This simply checks for an empty or blank hash.
      #
      # ==== History
      # * <tt>Created: 2016-12-16</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Extends
      # * Extends Ruby's <tt>Hash</tt> class
      #
      # ==== Params
      # * <tt>self(Hash):</tt> self is the hash to check
      #
      # ==== Returns
      # * <tt>(Boolean)</tt> Returns true if empty hash
      #
      # ==== Examples
      #  {}.blank?                    #=> true
      #  {lastname: 'jones'}.blank?   #=> false
      # ---
      def blank?
        empty?
      end

    end
  end
end

# now that the module has been built, lets extend Ruby's +Hash+ class to accept these methods
Hash.send(:include, Marskal::CoreExt::MyHash)
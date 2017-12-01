require 'active_support/deprecation'
require 'active_support/core_ext/module/deprecation'

module Marskal
  module CoreExt
    # used for deprecation warning messages. Date of final deprecation.
    DEPRECATION_HORIZON = 'sometime in 2017'

    # Name of gem to be used for deprecation warning messages
    GEM_NAME = 'marskal-core_ext'

    # :stopdoc:
    # this documents weird in RDoc, so we will suppress documentation for this line
    # this creates a new Deprecation class with the appropriate settings for this gem
    @@deprecation = ActiveSupport::Deprecation.new(DEPRECATION_HORIZON, GEM_NAME)
    # :startdoc:


    ##
    # This method displays a deprecation warning.
    #
    # ==== History
    # * <tt>Created: 2016-12-11</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    # ==== Params
    # * <tt>p_method(String):</tt> The method that is being deprecated
    # * <tt>p_message(String)(_defaults_ to: nil ):</tt> This is the message to be displayed. if nil, then Ruby's default message will be displayed
    #
    # ==== Examples
    #  Marskal::CoreExt.deprecate_this(:old_method, 'Please start using new_method')
    #
    #  # Output something like this:
    #  "DEPRECATION WARNING: old_method is deprecated and will be removed from marskal-core_ext sometime in 2017 (Please start using new_method). (called from irb_binding at (irb):3)"
    # ---
    def self.deprecate_this(p_method, p_message = nil)
      unless  ActiveSupport::Deprecation.silenced
        @@deprecation.deprecation_warning(p_method.to_s, p_message)
      end
    end

  end
end

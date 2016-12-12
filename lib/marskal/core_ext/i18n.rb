module Marskal
  module CoreExt

    ##
    # Extends functionality to Ruby's +I18n+ class
    #
    # ==== History
    # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    module MyI18n

      extend ActiveSupport::Concern

      module ClassMethods

        ##
        # *Note:* tnp is shorthand for translate with no plurals
        #
        # Translate a single string with no plurals, take :one or only one if only one exist.
        #
        # This method automatically grabs the item labeled :one
        # if :one is not available, then the first available translation will be returned
        #
        # ==== Extends
        # * Extends Ruby's <tt>I18n</tt> class
        #
        # ==== History
        # * <tt>Created: 2016-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
        #
        # ==== Returns
        # * <tt>(String)</tt> The translated text
        #
        # ==== Examples
        #  # en.yml file
        #
        #  #en:
        #  #   contact:
        #  #       one: "Contact"
        #  #       many: "Contacts"
        #  #   client: "Client"
        #
        #   I18n.tnp_single('contact')  #=> returns "Contact"
        #   I18n.tnp_single('client')   #=> returns "Client"
        # ---
        def tnp_single(p_token)
          l_translate =  t(p_token)
          if l_translate.is_a?(Hash)
            l_translate = l_translate[:one]||l_translate.first[1]
          end
          l_translate
        end

        ##
        # Take elements from the translation file for a given token and make into an array
        # if +:plural_label+ is passed, it will attempt to find the plural value from the translation file
        #
        # ==== Extends
        # * Extends Ruby's <tt>I18n</tt> class
        #
        # ==== History
        # * <tt>Created: 2016-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
        #
        # ==== Params
        # * <tt>p_token(Symbol or String):</tt> This is the token or key to lookup in the translation file
        # * <tt>p_options(Hash)(_defaults_ to: {} ):</tt> The options to use to process as desired
        #   * <tt>:plural_label (Symbol or String)(_defaults_ to: nil ):</tt> This is the label to use if we are collecting plural translations
        #
        # ==== Returns
        # * <tt>(Array)</tt> The Array of translated tokens
        #
        # ==== Examples
        #   # en.yml File
        #
        #   # en:
        #   #    investor_statuses:
        #   #        client:
        #   #        one: "Client"
        #   #        many: "Clients"
        #   #    prospect:
        #   #        one: "Prospect"
        #   #        many: "Prospects"
        #   #    cold:
        #   #        one: "Cold"
        #   #        many: "Cold Names"
        #   #    gender:
        #   #       male: "Male"
        #   #       female: "Female"
        #
        #   I18n.array_it('investor_statuses', plural_label: :many)
        #       #=>  returns ==> ["Clients", "Prospects", "Cold Names"]
        #
        #   I18n.array_it('investor_statuses', plural_label: :one)
        #       #=>  returns ==> ["Client", "Prospect", "Cold Name"]
        #
        #   # IMPORTANT_NOTE: If the token has been setup as plural the array returned will be a hash of
        #   # of all plural labels. See Example below:
        #   I18n.array_it('investor_statuses')
        #       #=>  returns ==> [{:one=>"Client", :many=>"Clients"}, {:one=>"Prospect", :many=>"Prospects"}, {:one=>"Cold", :many=>"Cold Names"}]
        #
        #
        #    #Example 2: Simple no plural terms
        #    I18n.array_it('gender') #=>   ["Male", "Female"]
        #
        # ---
        def array_it(p_token, options = {})
          options.assert_valid_keys(:plural_label)
          l_translate = options[:plural_label] ? plural_hash_it(p_token, options) : t(p_token)

          if l_translate.is_a?(Hash)
            l_return = []
            l_translate.each do |p_key, p_val|
              l_return << p_val
            end
          else
            l_return = Array(l_translate)
          end
          l_return
        end

        ##
        # Take elements from the translation file for a given token and make into an hash
        # if +:plural_label+ is passed, it will attempt to find the plural value from the translation file
        #
        # ==== Extends
        # * Extends Ruby's <tt>I18n</tt> class
        #
        # ==== History
        # * <tt>Created: 2016-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
        #
        # ==== Params
        # * <tt>p_token(Symbol or String):</tt> This is the token or key to lookup in the translation file
        # * <tt>p_options(Hash)(_defaults_ to: {} ):</tt> The options to use to process as desired
        #   * <tt>:plural_label (Symbol or String)(_defaults_ to: nil ):</tt> This is the label to use if we are collecting plural translations
        #
        # ==== Returns
        # * <tt>(Hash)</tt> The Hash of translated tokens
        #
        # ==== Examples
        #   # en.yml File
        #
        #   # en:
        #   #    investor_statuses:
        #   #        client:
        #   #        one: "Client"
        #   #        many: "Clients"
        #   #    prospect:
        #   #        one: "Prospect"
        #   #        many: "Prospects"
        #   #    cold:
        #   #        one: "Cold"
        #   #        many: "Cold Names"
        #   #    gender:
        #   #       male: "Male"
        #   #       female: "Female"
        #
        #     I18n.plural_hash_it('investor_statuses', plural_label: :many)
        #          #=>  {:client=>"Clients", :prospect=>"Prospects", :cold=>"Cold Names"}
        #
        #     I18n.plural_hash_it('investor_statuses')
        #          #=>  {:client=>"Client", :prospect=>"Prospect", :cold=>"Cold"}
        #
        #     I18n.plural_hash_it('gender')
        #          #=>  {:male=>"Male", :female=>"Female"}
        #
        # ---
        def plural_hash_it(p_token, options = {})
          options.assert_valid_keys(:plural_label)
          l_plural_label = options[:plural_label] || :one
          l_translate = t(p_token)
          if l_translate.is_a?(Hash)
            l_return = {}
            l_translate.each do |l_key, l_val|
              if l_val.is_a?(Hash)
                l_return.merge!(l_key => l_val[l_plural_label.to_sym]||"Not Found")
              else
                l_return.merge!(l_key => l_val)
              end
            end
          else
            l_return = l_translate
          end
          l_return
        end



      end  #end ClassMethods

    end
  end
end

# now that the module has been built, lets extend Ruby's +I18n+ class to accept these methods
I18n.send(:include, Marskal::CoreExt::MyI18n)




# :stopdoc: #

# @!visibility private
module MyMod
  extend ActiveSupport::Concern

  included do
    Array.send(:include, MyMod)
  end

  def an_instance_method
    88
  end

  module ClassMethods
    def a_class_method
      88
    end
  end
end

# module MyMod
#   def self.included(target)
#     target.send(:include, InstanceMethods)
#     target.extend ClassMethods
#     target.class_eval do
#       a_class_method
#     end
#   end
#
#   module InstanceMethods
#     def an_instance_method
#     end
#   end
#
#   module ClassMethods
#     def self.a_class_method
#       puts "a_class_method called"
#     end
#   end
# end
#
#
#

# @!visibility private
class MyClass
  # include MyMod
# irb> end
# a_class_method called
end

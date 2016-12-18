require 'test_helper'
require 'marskal/core_ext/object'


##
# This Section Tests all the Marskal::CoreExt::MyObject +Object+ extensions
#
# ==== History
# * <tt>Created: 2016-12-17</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
# ---
describe 'Marskal::CoreExt::MyObject' do
  ##
  # Prepare variables for testing
  #
  # ==== History
  # * <tt>Created: 2016-12-10</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
  #
  # ==== Variables
  # * <tt>MarskalTestObjectClass(Boolean):</tt> A class used for testing the adding and removing of attr_accessors methods
  # * <tt>@@klass(Boolean):</tt> The primary instantiated object to test with
  # ---
  before do

    #a dummy class to use for testing
    class MarskalTestObjectClass

      #dummy test attributes
      attr_accessor :attr1,  :attr2, :attr3

      def initialize
        @attr1 = 1
        @attr2 = 2
        @attr3 = 3
      end
    end

    #instantiate a test class
    @klass =  MarskalTestObjectClass.new()
  end

  ##
  # Remove MarskalTestObjectClass after each test
  #
  # ==== History
  # * <tt>Created: 2016-12-10</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
  # ---
  after do
    Object.send(:remove_const, :MarskalTestObjectClass)
  end

  describe 'Tests Instance method =>  add_attr_accessors' do

    it 'Produce Error if invalid type' do
      proc { @klass.add_attr_accessors([], TestHelper::GARBAGE.to_sym) }.must_raise ArgumentError
    end

    it 'Type(Default) allows both read and write to attribute' do
      @klass.add_attr_accessors(:myvar)
      (@klass.respond_to?('myvar') && @klass.respond_to?('myvar=')).must_equal true
    end

    it 'Type(:both) allows both read and write to attribute' do
      @klass.add_attr_accessors(:myvar, :both)
      (@klass.respond_to?('myvar') && @klass.respond_to?('myvar=')).must_equal true
    end

    it 'Type(:read) allow read but deny write the attribute' do
      @klass.add_attr_accessors(:myvar, :read)
      (@klass.respond_to?('myvar') && !@klass.respond_to?('myvar=')).must_equal true
    end

    it 'Type(:write) deny read but allow write the attribute' do
      @klass.add_attr_accessors(:myvar, :write)
      (!@klass.respond_to?('myvar') && @klass.respond_to?('myvar=')).must_equal true
    end

    it 'Multiple attributes can be passed to the method' do
      @klass.add_attr_accessors([:myvar1, :myvar2], :read)
      (@klass.respond_to?('myvar1') && @klass.respond_to?('myvar2')).must_equal true
    end

    it 'An existing attribute will not be overwritten' do
      l_current_value = @klass.attr1
      @klass.add_attr_accessors(:attr1)
      @klass.attr1.must_equal l_current_value
    end


  end

  describe 'Tests Instance method =>  remove_attr_accessors' do

    it 'Produce Error if invalid type' do
      proc { @klass.add_attr_accessors([], TestHelper::GARBAGE.to_sym) }.must_raise ArgumentError
    end

    it 'Type(Default) removes both read & write methods' do
      @klass.remove_attr_accessors(:attr1, :both)
      (either_respond_exist?('attr1') || either_method_exist?('attr1')).must_equal false
    end

    it 'Type(:both) removes both read & write methods' do
      @klass.remove_attr_accessors(:attr1, :both)
      (either_respond_exist?('attr1') || either_method_exist?('attr1')).must_equal false
    end

    it 'Type(:read) retains write, removes read method' do
      @klass.remove_attr_accessors(:attr1, :read)
      (!read_method_exist?('attr1') && write_method_exist?('attr1')).must_equal true
    end

    it 'Type(:read) removes read instance value' do
      @klass.remove_attr_accessors(:attr1, :read)
      read_respond_exist?('attr1').must_equal false
    end

    it 'Type(:write) retains read, removes write method' do
      @klass.remove_attr_accessors(:attr1, :write)
      (read_method_exist?('attr1') && !write_method_exist?('attr1')).must_equal true
    end

    it 'Type(:write) retains read instance value' do
      l_value = @klass.attr1
      @klass.remove_attr_accessors(:attr1, :write)
      @klass.attr1.must_equal l_value
    end

    it 'Removes multiple fields in 1 call' do
      @klass.remove_attr_accessors([:attr1, :attr2, :attr3])
      l_flag = false
      [:attr1, :attr2, :attr3].each do |l_attr|
        l_flag = l_flag || (either_respond_exist?(l_attr) || either_method_exist?(l_attr))
      end
      l_flag.must_equal false
    end

  end

  # return true if either a read or a write instance variable exists
  def either_respond_exist?(p_attr)
    read_respond_exist?(p_attr) || write_respond_exist?(p_attr)
  end

  # return true if read instance variable exists
  def read_respond_exist?(p_attr)
    @klass.respond_to?(p_attr)
  end

  # return true if write instance variable exists
  def write_respond_exist?(p_attr)
    @klass.respond_to?("#{p_attr}=")
  end

  # return true if either a read or a write accessor method exists
  def either_method_exist?(p_attr)
    read_method_exist?(p_attr) || write_method_exist?(p_attr)
  end

  # return true if a read accessor method exists
  def read_method_exist?(p_attr)
    @klass.methods.include?("#{p_attr}".to_sym)
  end

  # return true if a write accessor method exists
  def write_method_exist?(p_attr)
    @klass.methods.include?("#{p_attr}=".to_sym)
  end


end



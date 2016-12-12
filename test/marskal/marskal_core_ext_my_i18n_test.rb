require 'test_helper'

##
# This Section Tests all the Marskal::CoreExt::MyI18n +I18n+ extensions
#
# ==== History
# * <tt>Created: 2016-10-2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
# ---
describe 'Marskal::CoreExt::MyI18n' do

  describe 'Tests Class method => I18n.tnp_single' do

    it 'Must return an String ' do
      I18n.tnp_single('contact').must_be_kind_of String
    end

    it 'Must return a singular translation labeled as :one' do
      I18n.tnp_single('contact').must_equal 'Contact'
    end

    it 'Return a only translation when :one is not present' do
      I18n.tnp_single('client').must_equal 'Client'
    end

    it "Return 'translation missing:' if token not present" do
      I18n.tnp_single('garbage').must_include 'translation missing:'
    end

  end

  describe 'Tests Class method => I18n.array_it' do

    it 'Must return an Array ' do
      I18n.array_it('gender').must_be_kind_of Array
    end

    it 'Return Array of translations when not set as plurals' do
      I18n.array_it('gender').must_equal ["Male", "Female"]
    end

    it 'Return an Array of plurals given proper :plural_label' do
      I18n.array_it('investor_statuses', plural_label: :many).must_equal ["Clients", "Prospects", "Cold Names"]
    end

    it 'Ret Array plural options if not given :plural_label' do
      I18n.array_it('investor_statuses').must_equal [{:one=>"Client", :many=>"Clients"}, {:one=>"Prospect", :many=>"Prospects"}, {:one=>"Cold", :many=>"Cold Names"}]
    end

    it 'Raise ArgumentError when given invalid options' do
      proc { I18n.array_it('investor_statuses', garbage: 'badoption') } .must_raise ArgumentError
    end

    it "Return 'translation missing:' if token not present" do
      I18n.array_it('garbage').first.must_include 'translation missing:'
    end



  end

  describe 'Tests Class method => I18n.plural_hash_it' do

    it 'Must return an Hash ' do
      I18n.plural_hash_it('gender').must_be_kind_of Hash
    end

    it 'Return Hash translations when not set up as plurals' do
      I18n.plural_hash_it('gender').must_equal ({ male: "Male", female: "Female" })
    end

    it 'Return Hash of given token with :plural_label' do
      I18n.plural_hash_it('investor_statuses', plural_label: :many).must_equal ({:client=>"Clients", :prospect=>"Prospects", :cold=>"Cold Names"})
    end

    it 'Ret Hash if set as plurals & no :plural_label' do
      I18n.plural_hash_it('investor_statuses').must_equal ({:client=>"Client", :prospect=>"Prospect", :cold=>"Cold"})
    end

    it 'Raise ArgumentError when given invalid options' do
      proc { I18n.plural_hash_it('investor_statuses', garbage: 'badoption') } .must_raise ArgumentError
    end

    it "Return 'translation missing:' if token not present" do
      I18n.plural_hash_it('garbage').must_include 'translation missing:'
    end



  end



end



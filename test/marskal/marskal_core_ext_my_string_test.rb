require 'test_helper'
require 'marskal/core_ext/string'

##
# This Section Tests all the Marskal::CoreExt +String+ extensions
#
# ==== History
# * <tt>Created: 2016-10-2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
#
# ---
describe 'Marskal::CoreExt::MyString' do

  describe 'Tests Instance method => replace_eol' do

    it 'Returns expected result using default params' do
      "Hello\r\nGoodbye".replace_eol.must_equal "Hello Goodbye"
    end

    it 'Returns expected result with custom params' do
      "Hello\r\nGoodbye".replace_eol("<br>").must_equal "Hello<br>Goodbye"
    end

    it 'Returns a String' do
      ''.replace_eol.must_be_kind_of String
    end

    it 'Returns self un-altereted if no new lines exist ' do
      'No New Lines'.replace_eol.must_equal 'No New Lines'
    end

  end

  describe 'Tests Instance method => unquote' do

    it 'Returns expected when only single quotes exist' do
      "Jenny's Desk".unquote.must_equal "Jennys Desk"
    end

    it 'Returns expected when only double quotes exist' do
      'Jennys "Desk"'.unquote.must_equal "Jennys Desk"
    end

    it 'Returns expected when any quotes exist' do
      "\"Jenny\" 'likes her' \"Desk\"".unquote.must_equal "Jenny likes her Desk"
    end

    it 'Returns a String' do
      ''.replace_eol.must_be_kind_of String
    end

    it 'Returns self un-altereted if no quotes exist ' do
      'No Quotes'.replace_eol.must_equal 'No Quotes'
    end

  end

  describe 'Tests Instance method => to_object' do

    it 'Returns expected object' do
      "marskal".to_object.must_equal Marskal
    end

    it 'Raise NameError when given an non existent object' do
      proc { "garbage".to_object  }.must_raise NameError
    end

  end

  describe 'Tests Instance method => is_valid_email?' do

    it 'Returns true when email is valid' do
      "sam@x.com".is_valid_email?.must_equal true
    end

    it 'Returns false when email is NOT valid' do
      "sam-x.com".is_valid_email?.must_equal false
    end

  end

  describe 'Tests Instance method => smart_comma_parse_to_array' do

    it 'Returns expected Array' do
      "field1, field2, field3".smart_comma_parse_to_array.must_be_kind_of Array
    end

    it 'Returns Complicated Select Statement' do
      l_sql = 'id,`primary`,  concat(`id`, name, "hello") as junk, last_col, 1+2, "hello, Mr. Mike" as greeting, [1,2,3] as an_array'
      l_sql.smart_comma_parse_to_array.must_equal ["id", "`primary`", "concat(`id`, name, \"hello\") as junk", "last_col", "1+2", "\"hello, Mr. Mike\" as greeting", "[1,2,3] as an_array"]
    end

    it 'Returns Simple Select Statement' do
      "field1, field2, field3".smart_comma_parse_to_array.must_equal ["field1", "field2", "field3"]
    end

  end

  describe 'Tests Instance method => indexes_of_char' do

    it 'Returns expected Array' do
      "field1, field2, field3".smart_comma_parse_to_array.must_be_kind_of Array
    end

    it 'Returns expected result when char is found' do
      "1,11,111,1111".indexes_of_char(',').must_equal [1, 4, 8]
    end

    it 'Returns empty array when char is NOT found' do
      "1,11,111,1111".indexes_of_char(':').must_equal []
    end

  end

  describe 'Tests Instance method => split_select_column_alias' do

    it 'Returns expected Array' do
      "field1".split_select_column_alias.must_be_kind_of Array
    end

    it 'Returns expected Array when col alias is given' do
      l_mysql = 'CONCAT(last_name, first_name) as full_name'
      l_mysql.split_select_column_alias.must_equal ['CONCAT(last_name, first_name)', 'full_name']
    end

    it 'Returns Array with blank 2nd elem if no alias exists' do
      'field1'.split_select_column_alias.last.must_be_empty
    end


  end

  describe 'Tests Instance method => remove_begin_end_char' do

    it 'Returns expected String' do
      "xxx".remove_begin_end_char(':').must_be_kind_of String
    end

    it 'Returns string with ends removed if found' do
      "'hello'".remove_begin_end_char("'").must_equal 'hello'
    end

    it 'Returns string untouched if surrounding chars found' do
      'last_name'.remove_begin_end_char("'").must_equal "last_name"
    end


  end

  describe 'Tests Instance method => sanitize_filename' do

    it 'Returns expected String' do
      "README.md".sanitize_filename.must_be_kind_of String
    end

    it 'Returns expected clean file given name with bad chars' do
      "File#Name$this-is_my_file.2.doc".sanitize_filename.must_equal "File_Name_this-is_my_file_2.doc"
    end

    it 'Returns file name untouched if ok already' do
      "README.md".sanitize_filename.must_equal "README.md"
    end


  end

  describe 'Tests Instance method => is_integer?' do

    it 'Returns a Boolean' do
      ''.is_integer?.must_be_boolean
    end

    it 'Returns true if all integers' do
      '123'.is_integer?.must_equal true
    end

    it 'Returns false if has decimals' do
      '1.2.3'.is_integer?.must_equal false
    end

    it 'Returns false if has letters' do
      'ABC'.is_integer?.must_equal false
    end

    it 'Returns false if blank' do
      ''.is_integer?.must_equal false
    end



  end



end



module Marskal
  module CoreExt

    ##
    # Extends functionality to Ruby's +String+ class
    #
    # ==== History
    # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    module MyString

      extend ActiveSupport::Concern


      ##
      # Replaces new line characters <b>\\n</b> or <b>\\r\\n</b> with the specified string, which defaults to ' '
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created:  2010-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> This string to parse
      # * <tt>p_str(String)(_defaults_ to: ' ' ):</tt> This string to replace the end of line characters
      #
      # ==== Returns
      # * <tt>(String)</tt> The string parsed with all end of line characters replaced by the specified string
      #
      # ==== Examples
      #   "Hello\r\nGoodbye".replace_eol          #=> "Hello Goodbye"
      #   "Hello\r\nGoodbye".replace_eol('<br>')  #=> "Hello<br>Goodbye"
      # ---
      def replace_eol(p_str = ' ')
        self.gsub(/(\r)?\n/, p_str)
      end

      ##
      # Removes quotes *'* and *"* characters
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created:  2010-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> This string to parse
      #
      # ==== Returns
      # * <tt>(String)</tt> The string parsed with all quotes removed
      #
      # ==== Examples
      #   "Jenny's Desk".unquote                      #=> "Jennys Desk"
      #   'My Friend\'s a quote, "Live Big"'.unquote  #=> "My Friends a quote, Live Big"
      # ---
      def unquote
        # self.gsub("'","").gsub('"', '')  #old code
        self.gsub(/["']/, '') #more efficient
      end

      ##
      # Converts a string into a ruby object
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created:  2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> This string to convert
      #
      # ==== Returns
      # * <tt>(Object)</tt> The string as represented as a RubyObject
      #
      # ==== Examples
      #   #NOTE: An error will occur may occur if the class or object is not defined already
      #   "marskal".to_object       #=> Marskal
      #   "user".to_object          #=> User
      # ---
      def to_object
        self.singularize.classify.constantize
      end

      ##
      # Checks if valid email format.
      # Its a simple checker and can likely be improved.
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> This email to validate
      #
      # ==== Returns
      # * <tt>(Boolean)</tt> true if email is of a valid format
      #
      # ==== Examples
      #   "sam@x.com".is_valid_email?   #=> true
      #   "sam-x.com".is_valid_email?   #=> false
      # ---
      def is_valid_email?
        ret = self =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\z/
        return ret.nil? ? false : true
      end
      #ex:
      #sql2 = 'id,`primary`,  concat(`id`, name, "hello") as junk, last_col, 1+2, "hello, Mr. Mike" as greeting, [1,2,3] as an_array'
      #returns and array of 7 elements

      ##
      # This is an imperfect but effective parser for the mysql select columns, however it expands slightly beyond that
      # This will take any string and spilt it into an array based on commas.
      # However it will ignore commas in the circumstances as defined by the Regex code below
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created: 2015-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> Comma delimited string to be parsed
      #
      # ==== Returns
      # * <tt>Array</tt> An Array where each comma separated field will be a separate array element
      #
      # ==== Examples
      #   sql = 'id,`primary`,  concat(`id`, name, "hello") as junk, last_col, 1+2, "hello, Mr. Mike" as greeting, [1,2,3] as an_array'
      #
      #   sql.smart_comma_parse_to_array #=> 7 element array as shown below
      #       returns #=> ["id", "`primary`", "concat(`id`, name, \"hello\") as junk", "last_col", "1+2", "\"hello, Mr. Mike\" as greeting", "[1,2,3] as an_array"]
      #
      #   "field1, field2, field3".smart_comma_parse_to_array #=>  ["field1", "field2", "field3"]
      #
      # ---
      def smart_comma_parse_to_array()
        p_new_str = self.clone              #lets copy string so we can make some temporary changes
        [ Regexp.new("(`.*?`)"),            #we will ignore commas between accent char ``
          Regexp.new("('.*?')"),            #ignore commas between single quotes ''
          Regexp.new("(\".*?\")"),          #ignore commas between double quotus ""
          Regexp.new("(\\{.*?\\})"),        #ignore commas between open and close curly braces {}
          Regexp.new("(\\[.*?\\])"),        #ignore commas between open and close brackets []
          Regexp.new("(\\(.*?\\))")         #ignore commas between open and close parenthesis ()
        ].each do |r|                       #lets process each search separately
          l_found = p_new_str.scan(r)       #find all string that match the Regex
          l_found.each do |l_str_array|     #find all occurrences of matches
            l_str_array.each do |str|         #lup through each find
              l_new_part = str.gsub(',', '~') #and temporarily replace the comma character, with any non comma character, in this case we use "~"
              p_new_str.sub!(str, l_new_part) #no place th is newly comma free string back into a copy of original(self) string as is
            end
          end
        end
        l_comma_locations = p_new_str.indexes_of_char(',')  #now commas only exists where the should be, so lets find each commas location
        l_comma_locations.insert(0,0) #lets insert a starting point, so that entire string gets processed, including what becomes before the first comma.
        p_new_str = self.clone        #copy string again, so we can rebuild now that we know where the legit commas are
        l_result = []                 #initialize our result array
        l_comma_locations.reverse.each do |idx|                                             #lup through all the comma backwards and crop the string as we go
          l_result.insert(0, p_new_str.slice!(idx..p_new_str.length).sub(',', ' ').strip)   #we are going backwards, so we need to insert the chopped strin back in proper order
        end
        l_result      #return the array
      end

      ##
      # Finds all the instances of the specified character in the specified string.
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created: 2015-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> String to be parsed
      # * <tt>p_char(String):</tt> Should only be one character. This will return all the locations that character is found
      #
      # ==== Returns
      # * <tt>Array</tt> An Array of integers representing the location of the char found
      #
      # ==== Examples
      #    "1,11,111,1111".indexes_of_char(',')  #=> returns [1, 4, 8]
      #    "1,11,111,1111".indexes_of_char(':')  #=> returns []
      # ---
      def indexes_of_char(p_char)
        (0 ... self.length).find_all { |i| self[i,1] == p_char }
      end

      ##
      # Used for help in preparing sql statements for MYSQL
      #
      # Returns a 2 element array==> [sql_expresession, alias] See *Examples*
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created: 2015-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> String to be parsed
      #
      # ==== Returns
      # * <tt>Array</tt> An Array of 2 elements the column name as on1 and the alias as another
      #
      # ==== Examples
      #   mysql = "CONCAT(last_name, first_name) as full_name"
      #   mysql.split_select_column_alias         #=> ['CONCAT(last_name, first_name)', 'full_name']
      #   "last_name".split_select_column_alias   #=> [last_name, '']
      # ---
      def split_select_column_alias
        index = self.downcase.rindex(' as ')              #simple check for as, not perfect, but should work in all normal cases
        if index.nil? || index == 0                       #if not found or found at zero, the we will assume there is no allias
          return [self.strip, '']                         #then clean up the space and return an with no alias
        else                                                                #otherwise split into to pieces the sql select expression
          return [self[0..index].strip, self[(index+3)..self.length].strip] #(usually a column) and then set the second parameter will be the alias.
        end

      end

      ##
      # Removes a specific char from the first and last character if they exist in both places, otherwise returns the string untouched.
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created: 2015-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> String to be parsed
      # * <tt>p_char(String):</tt> String should be length of 1. This will be the charcter to search for.
      #
      # ==== Returns
      # * <tt>String</tt> If char is found, then they are removed, otherwise returns string untouched
      #
      # ==== Examples
      #   "'hello'".remove_begin_end_char("'")    #=> "hello"
      #   "last_name".remove_begin_end_char("'")  #=> "last_name"
      # ---
      def remove_begin_end_char(p_char)
        self[0] == p_char && self[-1] == p_char ? self[1..(self.length-2)] : self
      end

      ##
      # Converts a string into a legit filename.
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created: 2016-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> String to be made into file name
      #
      # ==== Returns
      # * <tt>String</tt> file name
      #
      # ==== Examples
      #   "File#Name$this-is_my_file.2.doc".sanitize_filename #=> "File_Name_this-is_my_file_2.doc"
      # ---
      def sanitize_filename()
        # Split the name when finding a period which is preceded by some
        # character, and is followed by some character other than a period,
        # if there is no following period that is followed by something
        # other than a period (yeah, confusing, I know)
        fn = self.split(/(?<=.)\.(?=[^.])(?!.*\.[^.])/m)

        # We now have one or two parts (depending on whether we could find
        # a suitable period). For each of these parts, replace any unwanted
        # sequence of characters with an underscore
        fn.map! { |s| s.gsub(/[^a-z0-9\-]+/i, '_' )}

        # Finally, join the parts with a period and return the result
        return fn.join '.'
      end

      ##
      # Checks to see if the string qualifies as an integer value.
      #
      # ==== Extends
      # * Extends Ruby's <tt>String</tt> class
      #
      # ==== History
      # * <tt>Created: 2016-12-14</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Params
      # * <tt>self(String):</tt> String to be test if integer
      #
      # ==== Returns
      # * <tt>Boolean</tt> True if integer, false if not
      #
      # ==== Examples
      #   "1.2.3".is_integer?         #=> false
      #   "Nope".is_integer?          #=> false
      #   "10-22-33".is_integer?      #=> false
      #   "123".is_integer?           #=> true
      # ---
      def is_integer?
        self.to_i.to_s == self
      end

    end
  end
end

# now that the module has been built, lets extend Ruby's +String+ class to accept these methods
String.send(:include, Marskal::CoreExt::MyString)




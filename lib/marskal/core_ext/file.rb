module Marskal
  module CoreExt

    ##
    # Extends functionality to Ruby's +File+ class
    #
    # ==== History
    # * <tt>Created: 2013-ish</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
    #
    module MyFile

      extend ActiveSupport::Concern

      module ClassMethods

        ##
        # This method takes a file in Markdown (.md) language and makes it more readable for a terminal output
        #
        # ==== History
        # * <tt>Created: 2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
        #
        # ==== Params
        # * <tt>p_file(String):</tt> The Name of the markdown file to parse into text
        # * <tt>p_options(Hash)(_defaults_ to: nil ):</tt> Not being used at this time, but is available for future enhancements
        #
        # ==== Examples
        #  File.markdown_to_text('README.md')
        #
        # ---
        def markdown_to_text(p_file, p_options = {})
          l_success = false

          begin
            puts "\n\n"
            dashed_line_length = 20  #defaullt to 20 charcters long
            l_file = File.open(p_file, "r").each_line do |line|
              if line == "---\n"                                   # <hr> will be converted to dashed lines
                l_dashed_line = ''
                dashed_line_length.times { l_dashed_line += '-'}
                puts l_dashed_line
              elsif line[0] == '#'                                  # headings will be displayed as regular text
                idx = line.index(' ')
                puts line[idx..line.length].strip
              elsif line == "```\n"                                 #strip code blocks makers
                puts "\n"
                next
              else
                puts line.gsub(/[\n`]/, '')                         #otherwise just display text
              end

              #adjust the dashed line length to match the longest line
              dashed_line_length = [dashed_line_length, line.length].max if line.strip.length > 0

            end
            l_file.close
            l_success = true

          rescue Exception => error
            puts "............................[#{error.message}] reading file #{p_file}"
            l_success = false
          end

          l_success  #return success or failure

        end

      end
    end
  end
end

# now that the module has been built, lets extend Ruby's +File+ class to accept these methods
File.send(:include, Marskal::CoreExt::MyFile)




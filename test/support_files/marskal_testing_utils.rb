module Marskal
  module Testing
    module Utils

      ##
      # This suppresses all output to stderr and stdout. This way if a method
      # performs puts, it wont get output and integrated with legitimate testing output
      #
      # ==== History
      # * <tt>Created: 2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Examples
      #   before do
      #     Marskal::Testing::Utils.silence_output
      #   end
      #
      #   after do
      #     Marskal::Testing::Utils.enable_output
      #   end
      #
      #   describe 'Simple Test Example for true' do
      #
      #     it 'Must return true' do
      #       true.must_equal true
      #     end
      #
      #   end
      # ---
      def self.silence_output
        # Store the original stderr and stdout in order to restore them later
        @original_stderr = $stderr
        @original_stdout = $stdout

        l_dummy_stderr  = StringIO.new
        l_dummy_stdout  = StringIO.new

        # Redirect stderr and stdout
        $stderr = l_dummy_stderr
        $stdout = l_dummy_stdout
      end

      ##
      # This resets the ouput to normal after being reset by silence_output
      #
      # ==== History
      # * <tt>Created: 2016</tt> <b>Mike Urban</b> <mike@marskalgroup.com>
      #
      # ==== Examples
      #   #see silence_output for a complete example
      # ---
      def self.enable_output
        $stderr = @original_stderr
        $stdout = @original_stdout
        @original_stderr = nil
        @original_stdout = nil
      end



    end
  end
end
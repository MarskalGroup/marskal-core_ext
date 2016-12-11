
module Marskal
  module TestSupport
    GOT = 0
    EXPECTED = 1

    def assert_return_whats_expected(p_value_array)
      assert_equal p_value_array[GOT],  p_value_array[EXPECTED]
    end


  end
end


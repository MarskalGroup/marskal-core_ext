require 'test_helper'
require 'marskal/core_ext'

class Marskal::CoreExtTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Marskal::CoreExt::VERSION
  end

  def test_it_does_something_useful
    assert true
  end
end

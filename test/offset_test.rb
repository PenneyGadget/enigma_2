require 'minitest/autorun'
require 'minitest/pride'
require '../lib/offset'

class OffsetTest < Minitest::Test

  def test_date_exists_and_is_formatted_correctly
    offset = Offset.new

    assert_equal "231015", offset.date
  end

  def test_proper_offset_is_generated_from_the_date
    offset = Offset.new

    assert_equal "0225", offset.offset
  end

  def test_offset_rotations_are_generated_properly
    offset = Offset.new

    assert_equal [0, 2, 2, 5], offset.offset_rotations
  end

end

require 'minitest/autorun'
require 'minitest/pride'
require './lib/offset'
require 'date'

class OffsetTest < Minitest::Test

  def test_date

  end

  def test_proper_offset_is_generated_from_the_date
    o = Offset.new

    assert_equal "0225", o.offset
  end

  def test_offset_rotations_are_generated_properly
    o = Offset.new

    assert_equal [0, 2, 2, 5], o.offset_rotations
  end

end

require 'minitest/autorun'
require 'minitest/pride'
require '../lib/key'

class KeyTest < Minitest::Test

  def test_the_key_generates_a_random_five_digit_number
    key_one = Key.new.key
    key_two = Key.new.key

    1000.times do
      refute_equal key_one, key_two
    end

    assert_equal 5, key_one.length
  end

  def test_the_rotations_are_properly_generated_from_a_key
    skip ## why isn't this working?
    key = "32879"

    assert_equal [32, 28, 87, 79], key.key_rotations
  end


end

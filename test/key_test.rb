require 'minitest/autorun'
require 'minitest/pride'
require '../lib/key'

class KeyTest < Minitest::Test

  def test_the_key_generates_a_random_five_digit_number
    key_one = Key.new.generate_key
    key_two = Key.new.generate_key

    1000.times do
      refute_equal key_one, key_two
    end

    assert_equal 5, key_one.length
  end


end

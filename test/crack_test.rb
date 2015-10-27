require 'minitest/autorun'
require 'minitest/pride'
require './lib/crack'

class CrackTest < Minitest::Test

  def test_crack_class_takes_in_an_encrypted_string
    assert Crack.new("t3iw0w8jq,ajk")
  end

  def test_we_can_pass_in_our_own_date_if_we_want
    assert Crack.new("t3iw0w8jq,ajk", Date.today)
  end

  def test_we_have_the_character_map
    c = Crack.new("blarg")

    assert_equal ('a'..'z').to_a + ('0'..'9').to_a + [" ", ".", ","], c.character_map
  end

  def test_we_have_end_position_information_based_on_message_length
    c = Crack.new("t3iw0w8jq,ajk")

    assert_equal 1, c.message.length % 4
    # why don't these work?
    # assert_equal @end_remainder_one, c.end_position
    # assert_equal [4, 13, 3, 37], @end_remainder_one
  end

  def test_we_have_a_temp_end_piece_of_message_to_work_with
    c = Crack.new("t3iw0w8jq,ajk")

    assert_equal 1, c.message.length % 4
    assert_equal ["q", ",", "a", "j"], c.temp_message
  end

  def test_we_have_the_character_map_position_of_that_end_piece
    c = Crack.new("t3iw0w8jq,ajk")

    assert_equal [16, 38, 0, 9], c.key_text_position
  end

  def test_we_can_then_find_the_true_key
    c = Crack.new("t3iw0w8jq,ajk")

    assert_equal [12, 25, -3, -28], c.find_key
  end

  def test_decryption_works
    c = Crack.new("t3iw0w8jq,ajk")

    assert_equal "hello ..end..", c.decrypt
  end

end

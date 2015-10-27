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

  def test_we_have_the_to_the_character_map
    c = Crack.new("blarg")

    assert_equal ('a'..'z').to_a + ('0'..'9').to_a + [" ", ".", ","], c.character_map
  end

  def test_we_can_find_the_character_map_index_of_the_last_four_characters
    c = Crack.new("t3iw0w8jq,ajk")

    assert_equal [38, 0, 9, 10], c.key_text_position
  end

  def test_remainder_of_end_characters_to_determine_rotations
    c = Crack.new("t3iw0w8jq,ajk")

    assert_equal 1, c.message.length % 4
    assert_equal [1, 2, 3, 0], c.end_position
  end

  def test_we_can_find_the_difference_between_the_encrypted_position_and_the_true_position

  end

  def test_rotations_allign_to_proper_index

  end

  def test_decryption_works

  end

end

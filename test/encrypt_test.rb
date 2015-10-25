require 'minitest/autorun'
require 'minitest/pride'
require '../lib/encrypt'

class EncryptTest < Minitest::Test

  def test_character_map_exists
    e = Encrypt.new("Bonjour")

    assert_equal ('a'..'z').to_a + ('0'..'9').to_a + [" ", ".", ","], e.character_map
  end

  def test_character_map_is_39_characters_long
    e = Encrypt.new("Hola")

    assert_equal 39, e.character_map.length
  end

  def test_character_and_index_position_on_character_map_are_correct
    e = Encrypt.new("Hmmmpf")

    assert_equal "w", e.character_map[22]
    assert_equal "9", e.character_map[35]
    assert_equal " ", e.character_map[36]
  end

  def test_encrypt_class_exists_and_we_can_pass_in_a_message
    assert Encrypt.new("Hello there good looking..end..")
  end

  def test_we_have_the_option_to_pass_in_our_own_key_and_the_date
    e = Encrypt.new("Hello there good looking..end..", 12345, Date.today)

    assert e
    assert_equal [12, 23, 34, 45], e.key #not working, still randomizes key every time
    assert_equal [0, 2, 2, 5], e.offset #is this assertation valid? is it actually working/testing Date.today being passed in here??
  end

  def test_the_proper_rotation_is_being_calculated
    e = Encrypt.new("Hello", 12345, Date.today)

    assert_equal [12, 25, 36, 50], e.rotation #also not working due to key randomization
  end

  def test_rotated_position_method_is_finding_correct_index_of_letters_on_character_map
    e = Encrypt.new("Whazzup..end..")

    assert_equal [22, 7, 0, 25, 25, 20, 15, 37, 37, 4, 13, 3, 37, 37], e.message_position
  end

  def test_proper_rotations_for_encryption
    e = Encrypt.new("Hello", 12345, Date.today)

    assert_equal [19, 29, 47, 61, 26], e.rotated_position #failing due to randomization
  end

  def test_proper_rotations_for_a_more_complicated_message
    skip

  end

  def test_a_message_is_encrypted
    e = Encrypt.new("Hello ..end..", 12345, Date.today)

    assert_equal "t3iw0w8jq,ajk", e.encrypt
  end

end

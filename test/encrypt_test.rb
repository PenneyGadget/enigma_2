require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypt'
require 'timecop'
require 'date'

class EncryptTest < Minitest::Test

  def test_character_map_exists
    e = Encrypt.new("Bonjour")

    assert_equal (' '..'z').to_a, e.character_map
  end

  def test_character_map_is_91_characters_long
    e = Encrypt.new("Hola")

    assert_equal 91, e.character_map.length
  end

  def test_character_and_index_position_on_character_map_are_correct
    e = Encrypt.new("Hmmmpf")

    assert_equal "&", e.character_map[6]
    assert_equal "C", e.character_map[35]
    assert_equal " ", e.character_map[0]
    assert_equal "$", e.character_map[4]
    assert_equal "m", e.character_map[77]
  end

  def test_encrypt_class_exists_and_we_can_pass_in_a_message
    assert Encrypt.new("Hello there good looking..end..")
  end

  def test_we_have_the_option_to_pass_in_our_own_key_and_the_date
    date = Date.parse("2015-10-01")
    e = Encrypt.new("Hello there good looking [..end..]", 12345, date)

    assert e
    assert_equal [12, 23, 34, 45], e.key
    assert_equal [0, 2, 2, 5], e.offset
  end

  def test_the_proper_rotation_is_being_calculated
    date = Date.parse("2015-10-01")
    e = Encrypt.new("Hello??", 12345, date)

    assert_equal [12, 25, 36, 50], e.rotation
  end

  def test_rotated_position_method_is_finding_correct_index_of_letters_on_character_map
    e = Encrypt.new("Whazzup? (..end..)")

    assert_equal [55, 72, 65, 90, 90, 85,
                  80, 31, 0, 8, 14, 14,
                  69, 78, 68, 14, 14, 9], e.message_position
  end

  def test_proper_rotations_for_encryption
    date = Date.parse("2015-10-01")
    e = Encrypt.new("You + Me = **YES**", 12345, date)

    assert_equal [69, 104, 121, 50, 23,
                  25, 81, 119, 12, 54, 36,
                  60, 22, 82, 73, 101, 22, 35], e.rotated_position
  end

  def test_proper_rotations_for_a_more_complicated_message
    date = Date.parse("2015-10-01")
    e = Encrypt.new("Well. Hi there 666. I've been waiting for you >;-)", 24680, date)

    assert_equal [79, 117, 146, 161, 38, 48,
                  110, 158, 24, 132, 142,
                  154, 106, 117, 70, 107, 46,
                  70, 84, 85, 65, 55, 156,
                  154, 24, 114, 139, 154, 102,
                  48, 157, 150, 97, 132, 143,
                  163, 95, 48, 140, 164, 106,
                  48, 159, 164, 109, 48, 100, 112, 37, 57], e.rotated_position
  end

  def test_a_message_is_encrypted
    e = Encrypt.new("Well F&*#*@!", 12345, Date.today)

    assert_equal "c#5C,_J\\/CdS", e.encrypt
  end

end

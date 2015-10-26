require 'minitest/autorun'
require 'minitest/pride'
require './lib/decrypt'

class DecryptTest < Minitest::Test

  def test_character_map_exists
    d = Decrypt.new("Bonjour")

    assert_equal ('a'..'z').to_a + ('0'..'9').to_a + [" ", ".", ","], d.character_map
  end

  def test_character_map_is_39_characters_long
    d = Decrypt.new("Hola")

    assert_equal 39, d.character_map.length
  end

  def test_character_and_index_position_on_character_map_are_correct
    d = Decrypt.new("Hmmmpf")

    assert_equal "h", d.character_map[7]
    assert_equal "9", d.character_map[35]
    assert_equal " ", d.character_map[36]
  end

  def test_decrypt_class_exists_and_that_it_takes_a_message_and_key
    assert Decrypt.new("t3iw0w8jq,ajk", 12345)
  end

  def test_we_can_pass_in_the_date_if_we_want_and_it_works_the_same
    assert Decrypt.new("t3iw0w8jq,ajk", 12345, Date.today)
  end

  def test_the_proper_rotation_is_being_calculated
    d = Decrypt.new("Hello", 12345, Date.today)

    assert_equal [12, 25, 36, 50], d.rotation
  end

  def test_rotated_position_method_is_finding_correct_index_of_letters_on_character_map
    d = Decrypt.new("Hello ..end..")

    assert_equal [7, 4, 11, 11, 14, 36, 37, 37, 4, 13, 3, 37, 37], d.message_position
  end

  def test_proper_rotations_for_decryption
    date = Date.parse("2015-10-01")
    d = Decrypt.new("t3iw0", 12345, date)

    assert_equal [7, 4, -28, -28, 14], d.rotated_position
  end

  def test_proper_rotations_for_a_more_complicated_message
    date = Date.parse("2015-10-01")
    d = Decrypt.new("hndswg,pv2,lcn2arc3e6gohdgoh62au4g vcgqvfh", 24680, date)

    assert_equal [-17, -35, -67, -67, -2, -42, -32,
                  -70, -3, -20, -32, -74, -22, -35,
                  -42, -85, -7, -46, -41, -81, 8,
                  -42, -56, -78, -21, -42, -56, -78,
                  8, -20, -70, -65, 6, -42, -34, -64,
                   -22, -42, -54, -64, -19, -41], d.rotated_position
  end

  def test_a_message_is_decrypted
    d = Decrypt.new("t3iw0w8jq,ajk", 12345, Date.today)

    assert_equal "hello ..end..", d.decrypt
  end

end

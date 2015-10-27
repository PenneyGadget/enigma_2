require 'minitest/autorun'
require 'minitest/pride'
require './lib/decrypt'

class DecryptTest < Minitest::Test

  def test_character_map_exists
    d = Decrypt.new("Bonjour")

    assert_equal (' '..'z').to_a, d.character_map
  end

  def test_character_map_is_39_characters_long
    d = Decrypt.new("Hola")

    assert_equal 91, d.character_map.length
  end

  def test_character_and_index_position_on_character_map_are_correct
    d = Decrypt.new("Hmmmpf!")

    assert_equal "'", d.character_map[7]
    assert_equal "C", d.character_map[35]
    assert_equal "D", d.character_map[36]
    assert_equal "z", d.character_map[90]
    assert_equal " ", d.character_map[0]
  end

  def test_decrypt_class_exists_and_that_it_takes_a_message_and_key
    assert Decrypt.new("t3iw0w8jq,ajk", 12345)
  end

  def test_we_can_pass_in_our_own_date_if_we_want_and_it_works_the_same
    assert Decrypt.new("t3iw0w8jq,ajk", 12345, Date.today)
  end

  def test_the_proper_rotation_is_being_calculated
    d = Decrypt.new("BLARG!!", 12345, Date.today)

    assert_equal [12, 25, 36, 50], d.rotation
  end

  def test_rotated_position_method_is_finding_correct_index_of_letters_on_character_map
    d = Decrypt.new("Hello ..end..")

    assert_equal [40, 69, 76, 76, 79, 0, 14, 14, 69, 78, 68, 14, 14], d.message_position
  end

  def test_proper_rotations_for_decryption
    date = Date.parse("2015-10-01")
    d = Decrypt.new("t3iw0", 12345, date)

    assert_equal [72, -6, 37, 37, 4], d.rotated_position
  end

  def test_proper_rotations_for_a_more_complicated_message
    date = Date.parse("2015-10-01")
    d = Decrypt.new("l=Tm8>^uk$f],DWv8!Zi(PLn8IS_8VkyXQn%UP^n2;Q99", 24680, date)

    assert_equal [52, -19, -18, -8, 0, -18,
                  -8, 0, 51, -44, 0, -24, -12,
                  -12, -15, 1, 0, -47, -12,
                  -12, -16, 0, -26, -7, 0, -7,
                  -19, -22, 0, 6, 5, 4, 32, 1,
                  8, -80, 29, 0, -8, -7, -6, -21, -21, -60, 1], d.rotated_position
  end

  def test_a_message_is_decrypted
    d = Decrypt.new("c&s8mZ*RZ#5Cu#ES", 12345, Date.today)

    assert_equal "WhOaaAa Nellie!!", d.decrypt
  end

end

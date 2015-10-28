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

    assert_equal (' '..'z').to_a, c.character_map
  end

  def test_we_have_end_position_information_based_on_message_length
    c = Crack.new("Xi:Xp]0u8S':8_,8UZuN7S#8NM)OOi:XX")

    assert_equal 1, c.message.length % 4
    assert_equal [69, 78, 68, 14], c.end_remainder_one
  end

  def test_we_have_a_temp_end_piece_of_message_to_work_with
    c = Crack.new("Xi:Xp]0u8S':8_,8UZuN7S#8NM)OOi:XX")

    assert_equal 1, c.message.length % 4
    assert_equal ["O", "i", ":", "X"], c.temp_message
  end

  def test_we_have_the_character_map_position_of_that_end_piece
    c = Crack.new("Xi:Xp]0u8S':8_,8UZuN7S#8NM)OOi:XX")

    assert_equal [47, 73, 26, 56], c.key_text_position
  end

  def test_we_can_then_find_the_true_key
    c = Crack.new("Xi:Xp]0u8S':8_,8UZuN7S#8NM)OOi:XX")

    assert_equal [69, 86, 49, 42], c.find_key
  end

  def test_decryption_works
    c = Crack.new("6CN\\N7Dyq-;>q9@<34.Rp-7<,'=S-CN\\69R`q,-`:")
    c2 = Crack.new ("T#49 9QVq,,V:")

    assert_equal "****By George we've done it!!**** ..end..", c.decrypt
    assert_equal "Hello ..end..", c2.decrypt
  end

end

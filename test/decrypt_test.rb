require 'minitest/autorun'
require 'minitest/pride'
require '../lib/decrypt'

class DecryptTest < Minitest::Test

  def test_decrypt_class_exists_and_that_it_takes_in_a_string_and_key
    assert Decrypt.new("t3iw0w8jq,ajk", 12345)
  end

  def test_we_can_pass_in_the_date_if_we_want
    assert Decrypt.new("t3iw0w8jq,ajk", 12345, Date.today)
  end

  def test_the_proper_rotation_is_being_calculated
    d = Decrypt.new("Hello", 12345, Date.today)

    assert_equal [12, 25, 36, 50], d.rotation #not working due to key randomization
  end

end

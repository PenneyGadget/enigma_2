require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def test_enigma_class_exists
    assert Enigma.new
  end

  def test_a_new_random_key_is_generated_for_every_encryption
    100.times do
      refute_equal Enigma.new.encrypt("Hello"), Enigma.new.encrypt("Hello")
    end
  end

  def test_we_can_encrypt_a_message_when_we_pass_in_our_own_key
    e = Enigma.new

    assert_equal "ufE[3VHgFmPtSVCOSz", e.encrypt("Puppies!!! ..end..", 37465)
  end

  def test_we_can_encrypt_a_message_when_we_pass_in_our_own_key_and_todays_date
    e = Enigma.new

    assert_equal "ufE[3VHgFmPtSVCOSz", e.encrypt("Puppies!!! ..end..", 37465, Date.today)
  end

  def test_we_can_encrypt_a_message_when_we_pass_in_our_own_key_and_any_date
    e = Enigma.new
    date = Date.parse("2013-04-01")

    assert_equal "uiI_3YLkFpTxSYGSS\"", e.encrypt("Puppies!!! ..end..", 37465, date)
  end

  def test_we_can_decrypt_a_message_with_a_key_and_no_date
    e = Enigma.new
    encrypted = "ufE[3VHgFmPtSVCOSz"

    assert_equal "Puppies!!! ..end..", e.decrypt(encrypted, 37465)
  end

  def test_we_can_decrypt_a_message_with_a_key_and_todays_date
    e = Enigma.new
    encrypted = "ufE[3VHgFmPtSVCOSz"

    assert_equal "Puppies!!! ..end..", e.decrypt(encrypted, 37465, Date.today)
  end

  def test_we_can_decrypt_a_message_with_a_key_and_any_date
    e = Enigma.new
    encrypted = "ufE[3VHgFmPtSVCOSz"
    date = Date.parse("2015-10-01")

    assert_equal "Puppies!!! ..end..", e.decrypt(encrypted, 37465, date)
  end

  def test_we_can_crack_an_encrypted_message
    e = Enigma.new
    encrypted = "ufE[3VHgFmPtSVCOSz"

    assert_equal "Puppies!!! ..end..", e.crack(encrypted)
  end

  def test_we_can_crack_a_message_with_todays_date
    e = Enigma.new
    encrypted = "ufE[3VHgFmPtSVCOSz"

    assert_equal "Puppies!!! ..end..", e.crack(encrypted, Date.today)
  end

  def test_we_can_crack_a_message_with_any_date
    e = Enigma.new
    encrypted = "ufE[3VHgFmPtSVCOSz"
    date = Date.parse("2015-10-01")

    assert_equal "Puppies!!! ..end..", e.crack(encrypted, date)
  end

  def test_we_can_crack_a_message_with_newlines
    e = Enigma.new
    encrypted = "@1`dgGh`]>Ysq;i@gCvks5hs_;]f_f\"&]:X&&"

    assert_equal "Hello there youHow's it going?..end..", e.crack(encrypted)
  end

end

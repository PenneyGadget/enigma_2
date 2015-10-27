# require_relative 'key'
# require_relative 'offset'
require_relative 'encrypt'
require_relative 'decrypt'
require_relative 'crack'

class Enigma

  def encrypt(message, key = nil, date = nil)
    Encrypt.new(message, key, date).encrypt
  end

  def decrypt(message, key, date = nil)
    Decrypt.new(message, key, date).decrypt
  end

  def crack(message, date = nil)
    Crack.new(message, date = nil).decrypt
  end

end

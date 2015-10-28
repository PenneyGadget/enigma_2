require_relative 'encrypt'  # => true
require_relative 'decrypt'  # => true
require_relative 'crack'    # => true

class Enigma

  def encrypt(message, key = nil, date = nil)
    Encrypt.new(message, key, date).encrypt    # => "ufE[3VHgFmPtSVCOSz"
  end

  def decrypt(message, key, date = nil)
    Decrypt.new(message, key, date).decrypt
  end

  def crack(message, date = nil)
    Crack.new(message, date = nil).decrypt
  end

end

e = Enigma.new                          # => #<Enigma:0x007fd540941200>
e.encrypt("Puppies!!! ..end..", 37465)  # => "ufE[3VHgFmPtSVCOSz"

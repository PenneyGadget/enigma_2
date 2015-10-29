
class Key

  attr_reader :key

  def initialize(digits = nil)
    @key = digits || generate_key
  end

  def generate_key
    key = rand(0..99999).to_s
    key.rjust(5, "0")
  end

  def key_rotations
    string_key = key.to_s
    a = string_key[0..1]
    b = string_key[1..2]
    c = string_key[2..3]
    d = string_key[3..4]
    [a, b, c, d].map { |r| r.to_i }
  end

end

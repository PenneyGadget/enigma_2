
class Key

  attr_reader :key

  def initialize(digits = nil)
    @key = digits || generate_key
  end

  def generate_key
    key = rand(0..99999).to_s
    if key.length < 5
      key.rjust(5, "0")
    else
      key
    end
  end

  def key_rotations
    string_key = key.to_s
    a = string_key[0..1]
    b = string_key[1..2]
    c = string_key[2..3]
    d = string_key[3..4]
    rotations = [a, b, c, d].map do |r|
      r.to_i
    end
  end

end

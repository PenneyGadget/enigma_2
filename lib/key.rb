
class Key

  attr_accessor :key  # => nil

  def initialize
    @key = generate_key
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
    a = key[0].to_s + key[1].to_s
    b = key[1].to_s + key[2].to_s
    c = key[2].to_s + key[3].to_s
    d = key[3].to_s + key[4].to_s
    rotations = [a, b, c, d].map do |r|
      r.to_i
    end
  end

end

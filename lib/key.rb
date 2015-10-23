
class Key

  def generate_key
    key = rand(0..99999).to_s
    if key.length < 5
      key.rjust(5, "0")
    else
      key
    end
  end

  def create_rotations

  end



end

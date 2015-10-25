require_relative 'offset'
require_relative 'key'

class Encrypt

  attr_reader :key, :offset, :character_map

  def initialize(message, key=nil, offset=nil)
    @character_map = ('a'..'z').to_a + ('0'..'9').to_a + [" ", ".", ","]
    @key = Key.new.key_rotations
    @offset = Offset.new.offset_rotations
    @message = message
  end

  def rotation
    a = key[0] + offset[0]
    b = key[1] + offset[1]
    c = key[2] + offset[2]
    d = key[3] + offset[3]
    [a, b, c, d]
  end

  def message_position
    position = @message.downcase.chars.to_a.map { |letter| @character_map.index(letter) }
  end

  def rotated_position
    position = []
    counter = 0
    message_position.each do |num|
      position << num + rotation[counter]
      counter = (counter + 1) % rotation.length
    end
    position
  end

  def encrypt
    location = rotated_position.map { |num| num % 39 }
    location.map { |num| @character_map.values_at(num) }.join
  end

end

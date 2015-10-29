require_relative 'offset'
require_relative 'key'

class Decrypt

  attr_reader :key, :offset, :character_map

  def initialize(message, key = nil, date = nil)
    @character_map = (' '..'z').to_a
    @key = Key.new(key).key_rotations
    @original_key = key
    @offset = Offset.new(date).offset_rotations
    @message = message
  end

  def rotation
    pairs = key.zip(offset)
    pairs.map { |p| p.reduce(:+) }
  end

  def message_position
    @message.chars.to_a.map { |letter| @character_map.index(letter) }
  end

  def rotated_position
    position = []
    counter = 0
    message_position.each do |num|
      position << num - rotation[counter]
      counter = (counter + 1) % rotation.length
    end
    position
  end

  def decrypt
    location = rotated_position.map { |num| num % 91 }
    location.map { |num| @character_map.values_at(num) }.join
  end

end

if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0])
  d = Decrypt.new(message, ARGV[2])
  decrypted = d.decrypt
  f = File.new(ARGV[1], "w")
  f.write(decrypted)
  puts "Created '#{ARGV[1]}' with the key #{ARGV[2]} and date #{ARGV[3]}"
end

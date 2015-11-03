require_relative 'offset'
require_relative 'key'

class Encrypt

  attr_reader :key, :offset, :character_map, :original_key

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
    @message.gsub!("\n", "")
    @message.chars.to_a.map { |letter| @character_map.index(letter) }
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
    location = rotated_position.map { |num| num % 91 }
    location.map { |num| @character_map.values_at(num) }.join
  end

  def reformat_key
    first_two = key.shift
    proper_key = first_two.to_s.chars
    key.each do |num|
      proper_key << num.to_s[-1]
    end
    proper_key = proper_key.join.to_i
  end

end

if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0])
  e = Encrypt.new(message)
  encrypted = e.encrypt
  f = File.new(ARGV[1], "w")
  f.write(encrypted)
  puts "Created '#{ARGV[1]}' with the key #{e.reformat_key} and date #{Date.today.strftime("%d%m%y")}"
end

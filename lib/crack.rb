require_relative 'offset'
require_relative 'key'
require_relative 'decrypt'

class Crack

  attr_reader :offset, :character_map, :message, :end_remainder_one

  def initialize(message, date = nil)
    @character_map = (' '..'z').to_a
    @offset = Offset.new(date).offset_rotations
    @message = message
    @end_remainder_zero = [78, 68, 14, 14]
    @end_remainder_one = [69, 78, 68, 14]
    @end_remainder_two = [14, 69, 78, 68]
    @end_remainder_three = [14, 14, 69, 78]
  end

  def end_position
    if message.length % 4 == 0
      @end_remainder_zero
    elsif message.length % 4 == 1
      @end_remainder_one
    elsif message.length % 4 == 2
      @end_remainder_two
    else message.length % 4 == 3
      @end_remainder_three
    end
  end

  def temp_message
    if message.length % 4 == 0
      temp_message = message
    elsif message.length % 4 == 1
      temp_message = message[0..-2]
    elsif message.length % 4 == 2
      temp_message = message[0..-3]
    else message.length % 4 == 3
      temp_message = message[0..-4]
    end
    temp_message.chars[-4..-1]
  end

  def key_text_position
    temp_message.map { |char| @character_map.index(char) }
  end

  def find_key
    true_key = []
    true_key << (key_text_position[0] - end_position[0])
    true_key << (key_text_position[1] - end_position[1])
    true_key << (key_text_position[2] - end_position[2])
    true_key << (key_text_position[3] - end_position[3])
  end

  def full_message_position
    position = @message.chars.to_a.map { |letter| @character_map.index(letter) }
  end

  def rotated_position
    position = []
    counter = 0
    full_message_position.each do |num|
      position << num - find_key[counter]
      counter = (counter + 1) % find_key.length
    end
    position
  end

  def decrypt
    location = rotated_position.map { |num| num % 91 }
    location.map { |num| @character_map.values_at(num) }.join
  end

end

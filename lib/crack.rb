require_relative 'offset'
require_relative 'key'
require_relative 'decrypt'

class Crack

  attr_reader :offset, :character_map

  def initialize(message, date = nil)
    @character_map = ('a'..'z').to_a + ('0'..'9').to_a + [" ", ".", ","]
    @offset = Offset.new(date).offset_rotations
    @message = message
    @end_position = [13, 3, 37, 37]
  end

  def key_text_position
    text = @message.chars[-4..-1]
    text.map { |char| @character_map.index(char) }
  end

  def method_name

  end

end

c = Crack.new("t3iw0w8jq,ajk")
c.key_text_position

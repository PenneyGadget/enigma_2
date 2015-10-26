require 'date'

class Offset
  attr_reader :date

  def initialize(input_date = nil)
    @date = input_date || Date.today
  end

  def offset
    (date.strftime("%d%m%y").to_i ** 2).to_s[-4..-1]
  end

  def offset_rotations
    a = offset[0]
    b = offset[1]
    c = offset[2]
    d = offset[3]
    rotations = [a, b, c, d].map do |r|
      r.to_i
    end
  end

end

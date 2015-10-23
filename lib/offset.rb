require 'date'
require 'pry'

class Offset

  def initialize
    @date = date
  end

  def date
    Date.today.strftime("%d%m%y")
  end

  def offset
    (date.to_i ** 2).to_s[-4..-1]
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

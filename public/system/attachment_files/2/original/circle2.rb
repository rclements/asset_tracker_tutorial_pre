class Circle
  attr_accessor :radius

  def initialize(radius)
    @radius = radius.to_i
  end

  def draw
    ((radius * -1)..radius).each do |y|
      ((radius * -1)..radius).each do |x|
        print is_on_circle(x, y)
      end
      print "\n"
    end
  end

  def is_on_circle(x, y)
    (x*x + y*y) == (radius*radius) ? '#' : '.'
  end
end

Circle.new(ARGV.shift).draw

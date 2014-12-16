module RubyRobot
  class Coordinate
    attr_reader :x, :y
    def initialize(x, y)
      @x = x
      @y = y
    end
    
    def +(coordinate)
      @x += coordinate.x
      @y += coordinate.y
    end
    
    def -(coordinate)
      @x -= coordinate.x
      @y -= coordinate.y
    end
    
    def ==(coordinate)
      (@x == coordinate.x and @y == coordinate.y)
    end
    
    def to_s()
      "["+@x+","+@y+"]"
    end
  end
end

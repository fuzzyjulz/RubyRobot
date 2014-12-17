module RubyRobot
  #A Coordinate, on two dimensions
  class Coordinate
    attr_reader :x, :y
    def initialize(x, y)
      @x = x
      @y = y
    end
    
    #Add two coordinates
    def +(coordinate)
      Coordinate.new(@x + coordinate.x, @y + coordinate.y)
    end
    
    #Subtract two coordinates
    def -(coordinate)
      Coordinate.new(@x - coordinate.x, @y - coordinate.y)
    end
    
    #Check that two coordinates are equal
    def ==(coordinate)
      (@x == coordinate.x and @y == coordinate.y)
    end
    
    #Display the coordinates
    def to_s()
      "[#{@x},#{@y}]"
    end
  end
end

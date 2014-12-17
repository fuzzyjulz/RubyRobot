module RubyRobot
  class Direction
    private
    def initialize(degrees, coordinate_component)
      @degrees = degrees
      @coordinate_component = coordinate_component
    end

    public
    LEFT = -90
    RIGHT = 90
    FULL_CIRCLE = 360
    
    NORTH = new(0,Coordinate.new(0,-1))
    SOUTH = new(180,Coordinate.new(0,1))
    EAST = new(90,Coordinate.new(1,0))
    WEST = new(270,Coordinate.new(-1,0))
      
    ALL = {NORTH: NORTH, 
           SOUTH: SOUTH, 
           EAST:  EAST, 
           WEST:  WEST}
    
    attr_reader :degrees, :coordinate_component
    
    def self.[](index)
      type = index.class
      if type == String or type == Symbol
        return ALL[index.to_s.upcase.to_sym]
      elsif type == Fixnum
        degrees = index % FULL_CIRCLE
        degrees += FULL_CIRCLE if degrees < 0
        directions = ALL.values.select {|direction| direction.degrees == degrees }

        raise OutOfBoundaryError, 
          "The degrees #{degrees} didn't map to a named direction." if directions.empty?
        
        return directions.first
      end
    end
    
    def name
      ALL.each_pair do |name, direction|
        return name.to_s if direction == self
      end
      nil
    end
  end
end

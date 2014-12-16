module RubyRobot
  class BoundaryCoordinates
    attr_reader :min, :max
    def initialize(min_coordinate, max_coordinate)
      @min = min_coordinate
      @max = max_coordinate

      if (@min.x > @max.x or @min.y > @max.y)
        raise OutOfBoundaryError,
            "The minimum dimensions #{@min} must be greater than the maximum dimension  #{@max} for a surface"
      end
    end
    
    def within_bounds?(new_coord)
      return false if new_coord.x < min.x or new_coord.x > max.x
      return false if new_coord.y < min.y or new_coord.y > max.y
      true
    end
  end
end

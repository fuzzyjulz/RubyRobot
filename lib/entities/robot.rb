module RubyRobot
  class Robot
    attr_reader :location, :facing_direction, :surface
    
    def initialize(location, facing_direction, surface)
      place(location, facing_direction, surface)
    end
    
    def place(location, facing_direction, surface)
      if !surface.within_bounds?(location)
        raise OutOfBoundaryError, "The Coordinate #{location} is outside the boundaries of the new surface."
      end
      
      @location = location
      @facing_direction = facing_direction
      @surface = surface
      
      self
    end
    
    def rotate_left
      @facing_direction = Direction[@facing_direction.degrees + Direction::LEFT]
      self
    end

    def rotate_right
      @facing_direction = Direction[@facing_direction.degrees + Direction::RIGHT]
      self
    end
    
    def move_forward
      new_location = @location + facing_direction.coordinate_component
      
      if !surface.within_bounds?(new_location)
        raise OutOfBoundaryError, "The movement has put the robot out of boundaries"
      end
      
      @location = new_location
      self
    end
    
    def report
      "#{location} #{facing_direction.name}"
    end
    
    def to_s
      report
    end
  end
end
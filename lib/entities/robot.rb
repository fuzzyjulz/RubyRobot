module RubyRobot
  #A Robot that is able to move about on a surface, and report on it's location
  class Robot
    attr_reader :location, :facing_direction, :surface
    
    def initialize(location, facing_direction, surface)
      place(location, facing_direction, surface)
    end
    
    #Place the robot on the surface. Could also be used to place on different surfaces
    def place(location, facing_direction, surface)
      if !surface.within_bounds?(location)
        raise OutOfBoundaryError, "The Coordinate #{location} is outside the boundaries of the new surface."
      end
      
      @location = location
      @facing_direction = facing_direction
      @surface = surface
      
      self
    end
    
    #Rotate the robot to the left
    def rotate_left
      @facing_direction = Direction[@facing_direction.degrees + Direction::LEFT]
      self
    end

    #Rotate the robot to the right
    def rotate_right
      @facing_direction = Direction[@facing_direction.degrees + Direction::RIGHT]
      self
    end
    
    #Move forward one step
    def move_forward
      new_location = @location + facing_direction.coordinate_component
      
      if !surface.within_bounds?(new_location)
        raise OutOfBoundaryError, "The movement has put the robot out of boundaries"
      end
      
      @location = new_location
      self
    end
    
    #Report on the location and direction of the robot
    def report
      "#{location} #{facing_direction.name}"
    end
    
    def to_s
      report
    end
  end
end
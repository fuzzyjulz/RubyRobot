module RubyRobot
  #A table representation
  class Table < BoundaryCoordinates
    def initialize(min_coordinate, max_coordinate)
      super(min_coordinate, max_coordinate)
    end
  end
end

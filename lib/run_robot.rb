require_relative "entities/boundary_coordinates"
require_relative "entities/table"
require_relative "entities/coordinate"
require_relative "controller/command_controller"
require_relative "errors/out_of_boundary_error"
require "pry"


module RubyRobot
  table = Table.new(Coordinate.new(0, 0), Coordinate.new(5, 5));
  
  controller = CommandController.new(table)
  
  while !controller.finished?
    controller.interpret_command("PLACE 0,0")
    exit
  end
end

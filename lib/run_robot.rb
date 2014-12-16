require "requires"
require "pry"


module RubyRobot
  table = Table.new(Coordinate.new(0, 0), Coordinate.new(5, 5));
  
  controller = CommandController.new(table)
  
  while !controller.finished?
    controller.interpret_command("PLACE 0,0")
    exit
  end
end

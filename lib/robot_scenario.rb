module RubyRobot
  class RobotScenario
    def initialize(ui)
      @ui = ui
    end
    
    def run()
      table = Table.new(Coordinate.new(0, 0), Coordinate.new(5, 5));
      
      controller = CommandController.new(@ui, table)
      
      @ui.write_text "Robot simulator ready to run!"
      @ui.write_text " Commands are:"
      @ui.write_text "  #{CommandController::COMMANDS.keys.join(", ")}"
      
      while !controller.finished?
        command = @ui.read_input
        begin
          controller.interpret_command(command)
        rescue OutOfBoundaryError, CommandError => e
          @ui.write_text " #{e}"
        end
      end
    end
  end
end

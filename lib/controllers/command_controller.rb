module RubyRobot
  class CommandController
    COMMANDS = {place: "PLACE",
                left: "LEFT",
                right: "RIGHT",
                move: "MOVE",
                report: "REPORT",
                exit: "EXIT"}.invert
                
    attr_reader :robot, :ui, :table
    
    def initialize(ui, table)
      @ui = ui
      @table = table
      @finished = false
    end
    
    def interpret_command(full_command)
      command_arr = full_command.split(/\s/,2)
      command_str = command_arr[0].upcase
      command_sym = COMMANDS[command_str]
      if !command_sym.nil?
        send("interpret_#{command_sym}", command_arr[1])
      else
        raise CommandError, "'#{command_str}' Command not recognised."
      end
    end
    
    def interpret_place(command)
      matches = command.upcase.match(/^\s*(\d+)\s*,\s*(\d+)\s*,\s*(NORTH|SOUTH|EAST|WEST)/)
      raise CommandError, "Invalid place command." if matches.nil?
      
      xpos = matches[1].to_i
      ypos = matches[2].to_i
      direction = matches[3]
      
      coords = Coordinate.new(xpos, ypos)
      direction = Direction[direction]
      
      if @robot.nil?
        @robot = Robot.new(coords, direction, @table)
      else
        @robot.place(coords, direction, @table)
      end
    end

    def ensure_placed
      raise CommandError, "The robot must be PLACEd first." if @robot.nil?
    end
    
    def interpret_left(command)
      ensure_placed
      @robot.rotate_left
    end
    
    def interpret_right(command)
      ensure_placed
      @robot.rotate_right
    end
    
    def interpret_move(command)
      ensure_placed
      @robot.move_forward
    end
    
    def interpret_report(command)
      ensure_placed
      @ui.write_text @robot.report
    end
    
    def interpret_exit(command)
      @finished = true
    end
    
    def finished?
      @finished
    end
  end
end

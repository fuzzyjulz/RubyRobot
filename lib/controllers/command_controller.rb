module RubyRobot
  #Is responsible for accepting commands and sending them off to the relevant
  # robot commands
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
    
    #Accepts a string command and processes the command
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
    
    #Places the robot with the given coordinates and direction
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

    #Check that the robot has been placed and report errors if it hasn't
    def ensure_placed
      raise CommandError, "The robot must be PLACEd first." if @robot.nil?
    end
    
    #Command the robot to turn left
    def interpret_left(command)
      ensure_placed
      @robot.rotate_left
    end
    
    #Command the robot to turn right
    def interpret_right(command)
      ensure_placed
      @robot.rotate_right
    end
    
    #Command the robot to move
    def interpret_move(command)
      ensure_placed
      @robot.move_forward
    end
    
    #Command the robot to report on it's location
    def interpret_report(command)
      ensure_placed
      @ui.write_text @robot.report
    end
    
    #Mark this command controller as ready to close
    def interpret_exit(command)
      @finished = true
    end
    
    #Check if this command controller has had the exit command issued.s
    def finished?
      @finished
    end
  end
end

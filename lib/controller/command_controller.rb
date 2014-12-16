module RubyRobot
  class CommandController
    COMMANDS = {place: "PLACE",
                left: "LEFT",
                right: "RIGHT",
                move: "MOVE",
                report: "REPORT",
                exit: "EXIT"}.invert
                
    attr_reader :robot
    
    def initialize(table)
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
        raise CommandException, "'#{command_str}' Command not recognised."
      end
    end
    
    def interpret_place(command)
      matches = command.match(/^\s*(\d+)\s*,\s*(\d+)/)
      xpos = matches[1]
      ypos = matches[2]
      
      raise CommandException, "Invalid place command." if xpos.nil? or ypos.nil?
    end

    def interpret_left(command)
      robot.left
    end
    
    def interpret_right(command)
      robot.right
    end
    
    def interpret_move(command)
      robot.move
    end
    
    def interpret_report(command)
      robot.report
    end
    
    def interpret_exit(command)
      @finished = true
    end
    
    def finished?
      @finished
    end
  end
end

module RubyRobot
  #A real implementation of the UI
  class RealUserUiImpl
    #write text to stdout
    def write_text(text)
      puts(text)
    end
    #read text from std in
    def read_input()
      print "> "
      $stdout.flush
      gets
    end
  end
end

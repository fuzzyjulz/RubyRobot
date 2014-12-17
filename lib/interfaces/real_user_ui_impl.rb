module RubyRobot
  class RealUserUiImpl
    def write_text(text)
      puts(text)
    end
    def read_input()
      gets
    end
  end
end

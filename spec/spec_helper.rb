require_relative '../lib/requires'

#A mock UI to be able to assert against the output
class RecordLastUiImpl
  attr_reader :last_output
  attr_writer :next_input
  
  def write_text(text)
    @last_output = text
  end
  def read_input()
    @next_input
  end
end
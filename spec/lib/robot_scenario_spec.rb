module RubyRobot
  describe RobotScenario do
    let(:ui) {RecordLastUiImpl.new}
    let(:scenario) {RubyRobot::RobotScenario.new(ui)}
  end
end
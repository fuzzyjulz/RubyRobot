require_relative "requires"
require_relative "interfaces/real_user_ui_impl"

RubyRobot::RobotScenario.new(RubyRobot::RealUserUiImpl.new).run()

require "spec_helper"

module RubyRobot
  describe CommandController do
    describe "#initialize" do
      let(:table) {Table.new(Coordinate.new(0,0), Coordinate.new(5,5))}
      it "creates the object" do
        cc = CommandController.new(RecordLastUiImpl.new, table)
        expect(cc).not_to eq(nil)
        expect(cc.table).to eq(table)
      end
    end
    
    describe "#interpret_command(command)" do
      let(:table) {Table.new(Coordinate.new(0,0), Coordinate.new(5,5))}
      let(:controller) {CommandController.new(RecordLastUiImpl.new, table)}
      it "can interpret all commands" do
        controller.interpret_command("PLACE 1,1,east")
        controller.interpret_command("move")
        controller.interpret_command("left")
        controller.interpret_command("Right")
        controller.interpret_command("report")
        controller.interpret_command("exit")
      end

      it "rejects invalid commands" do
        controller.interpret_command("PLACE 1,1,east")
        expect{controller.interpret_command("Boogieman")}.to raise_error(CommandError)
        expect{controller.interpret_command("moved")}.to raise_error(CommandError)
        expect{controller.interpret_command(" move")}.to raise_error(CommandError)
      end

      it "rejects commands given before a place commands" do
        expect{controller.interpret_command("move")}.to raise_error(CommandError)
        expect{controller.interpret_command("left")}.to raise_error(CommandError)
        expect{controller.interpret_command("right")}.to raise_error(CommandError)
        expect{controller.interpret_command("move")}.to raise_error(CommandError)
        expect{controller.interpret_command("report")}.to raise_error(CommandError)
        controller.interpret_command("exit")
      end
      it "correctly sends command and parameters to the correct method" do
        expect(controller.robot).to eq(nil)
        controller.interpret_command("PLACE 1,1,east")
        expect(controller.robot).not_to eq(nil)
        expect(controller.robot.report).to eq("[1,1] EAST")
      end
    end
    
    describe "#interpret_place(command)" do
      let(:table) {Table.new(Coordinate.new(0,0), Coordinate.new(5,5))}
      let(:controller) {CommandController.new(RecordLastUiImpl.new, table)}
      it "can interpret a valid place command" do
        expect(controller.robot).to eq(nil)
        controller.interpret_place("1,1,east")
        expect(controller.robot.report).to eq("[1,1] EAST")
        expect(controller.robot).not_to eq(nil)
        controller.interpret_place("2 , 2 , WEsT")
        expect(controller.robot.report).to eq("[2,2] WEST")
      end
      it "rejects invalid place commands" do
        expect{controller.interpret_place("A1,1,east")}.to raise_error(CommandError)
        expect{controller.interpret_place("1,A1,east")}.to raise_error(CommandError)
      end
    end

    describe "#interpret_left(command)" do
      let(:table) {Table.new(Coordinate.new(0,0), Coordinate.new(5,5))}
      let(:controller) {CommandController.new(RecordLastUiImpl.new, table)}
      it "can interpret a valid command" do
        controller.interpret_place("1,1,east")
        controller.interpret_left("")
        expect(controller.robot.report).to eq("[1,1] NORTH")
      end
      it "rejects if the robot has not been placed" do
        expect{controller.interpret_left("")}.to raise_error(CommandError)
      end
    end

    describe "#interpret_right(command)" do
      let(:table) {Table.new(Coordinate.new(0,0), Coordinate.new(5,5))}
      let(:controller) {CommandController.new(RecordLastUiImpl.new, table)}
      it "can interpret a valid command" do
        controller.interpret_place("1,1,east")
        controller.interpret_right("")
        expect(controller.robot.report).to eq("[1,1] SOUTH")
      end
      it "rejects if the robot has not been placed" do
        expect{controller.interpret_right("")}.to raise_error(CommandError)
      end
    end

    describe "#interpret_move(command)" do
      let(:table) {Table.new(Coordinate.new(0,0), Coordinate.new(5,5))}
      let(:controller) {CommandController.new(RecordLastUiImpl.new, table)}
      it "can interpret a valid command" do
        controller.interpret_place("1,1,east")
        controller.interpret_move("")
        expect(controller.robot.report).to eq("[2,1] EAST")
      end
      it "rejects if the robot has not been placed" do
        expect{controller.interpret_move("")}.to raise_error(CommandError)
      end
    end

    describe "#interpret_report(command)" do
      let(:table) {Table.new(Coordinate.new(0,0), Coordinate.new(5,5))}
      let(:controller) {CommandController.new(RecordLastUiImpl.new, table)}
      it "can interpret a valid command" do
        controller.interpret_place("1,1,east")
        expect(controller.ui.last_output).to eq(nil)
        controller.interpret_report("")
        expect(controller.ui.last_output).to eq("[1,1] EAST")
      end
      it "rejects if the robot has not been placed" do
        expect{controller.interpret_report("")}.to raise_error(CommandError)
      end
    end

    describe "#interpret_exit(command)" do
      let(:table) {Table.new(Coordinate.new(0,0), Coordinate.new(5,5))}
      let(:controller) {CommandController.new(RecordLastUiImpl.new, table)}
      it "can interpret a valid command" do
        expect(controller.finished?).to eq(false)
        controller.interpret_exit("")
        expect(controller.finished?).to eq(true)
        controller.interpret_exit("")
        expect(controller.finished?).to eq(true)
      end
    end
  end
end
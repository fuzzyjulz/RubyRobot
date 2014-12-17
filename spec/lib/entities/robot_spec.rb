require "spec_helper"

module RubyRobot
  describe Robot do
    describe "#initialize" do
      let(:boundary) {BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(2,2))}
      let(:origin) {Coordinate.new(1,2)}
      it "correctly initialises a robot" do
        expect(Robot.new(origin, Direction::NORTH, boundary).report).to eq("[1,2] NORTH")
      end
    end
    
    describe "#place" do
      let(:robot) {Robot.new(origin, Direction::EAST, boundary)}
      let(:boundary) {BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(2,3))}
      let(:tiny_boundary) {BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(1,1))}
      let(:origin) {Coordinate.new(1,2)}
      let(:origin2) {Coordinate.new(2,1)}
      let(:outside_bounds) {Coordinate.new(-1,0)}
      it "sets the location correctly" do
        expect(robot.place(origin, Direction::SOUTH, boundary).report).to eq("[1,2] SOUTH")
        expect(robot.place(origin2, Direction::SOUTH, boundary).report).to eq("[2,1] SOUTH")
      end
      it "reports out of boundary issues" do
        expect{robot.place(outside_bounds, Direction::EAST, boundary)}.to raise_error(OutOfBoundaryError)
        expect{robot.place(origin, Direction::NORTH, tiny_boundary)}.to raise_error(OutOfBoundaryError)
      end
      it "sets the direction correctly" do
        expect(robot.place(origin, Direction::SOUTH, boundary).report).to eq("[1,2] SOUTH")
        expect(robot.place(origin, Direction::NORTH, boundary).report).to eq("[1,2] NORTH")
        expect(robot.place(origin, Direction::EAST, boundary).report).to eq("[1,2] EAST")
        expect(robot.place(origin, Direction::WEST, boundary).report).to eq("[1,2] WEST")
      end
      it "sets the surface correctly" do
        expect(robot.place(origin, Direction::SOUTH, boundary).report).to eq("[1,2] SOUTH")
        expect{robot.place(origin, Direction::SOUTH, tiny_boundary)}.to raise_error(OutOfBoundaryError)
        expect(robot.place(origin, Direction::SOUTH, boundary).report).to eq("[1,2] SOUTH")
      end
    end
    
    describe "#rotate_left" do
      let(:robot) {Robot.new(origin, Direction::SOUTH, boundary)}
      let(:boundary) {BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(2,2))}
      let(:origin) {Coordinate.new(1,2)}
      it "sets the direction correctly" do
        expect(robot.rotate_left.report).to eq("[1,2] EAST")
        expect(robot.rotate_left.report).to eq("[1,2] NORTH")
        expect(robot.rotate_left.report).to eq("[1,2] WEST")
        expect(robot.rotate_left.report).to eq("[1,2] SOUTH")
        expect(robot.rotate_left.report).to eq("[1,2] EAST")
        expect(robot.rotate_left.report).to eq("[1,2] NORTH")
      end
    end
    
    describe "#rotate_right" do
      let(:robot) {Robot.new(origin, Direction::SOUTH, boundary)}
      let(:boundary) {BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(2,2))}
      let(:origin) {Coordinate.new(1,2)}
      it "sets the direction correctly" do
        expect(robot.rotate_right.report).to eq("[1,2] WEST")
        expect(robot.rotate_right.report).to eq("[1,2] NORTH")
        expect(robot.rotate_right.report).to eq("[1,2] EAST")
        expect(robot.rotate_right.report).to eq("[1,2] SOUTH")
        expect(robot.rotate_right.report).to eq("[1,2] WEST")
        expect(robot.rotate_right.report).to eq("[1,2] NORTH")
      end
    end
    
    describe "#move_forward" do
      let(:robot) {Robot.new(origin, Direction::SOUTH, boundary)}
      let(:boundary) {BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(2,2))}
      let(:origin) {Coordinate.new(1,2)}
      it "sets the direction correctly" do
        expect{robot.move_forward}.to raise_error(OutOfBoundaryError)
        expect(robot.rotate_right.report).to eq("[1,2] WEST")
        expect(robot.move_forward.report).to eq("[0,2] WEST")
        expect(robot.rotate_right.report).to eq("[0,2] NORTH")
        expect(robot.move_forward.report).to eq("[0,1] NORTH")
        expect(robot.move_forward.report).to eq("[0,0] NORTH")
        expect{robot.move_forward}.to raise_error(OutOfBoundaryError)
        expect(robot.rotate_right.report).to eq("[0,0] EAST")
        expect(robot.move_forward.report).to eq("[1,0] EAST")
      end
    end
    describe "#report" do
      let(:robot) {Robot.new(origin, Direction::SOUTH, boundary)}
      let(:boundary) {BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(2,2))}
      let(:origin) {Coordinate.new(1,2)}
      it "reports the location and direction properly" do
        expect(robot.report).to eq("[1,2] SOUTH")
        expect(robot.rotate_right.report).to eq("[1,2] WEST")
        expect(robot.move_forward.report).to eq("[0,2] WEST")
      end
    end
  end
end
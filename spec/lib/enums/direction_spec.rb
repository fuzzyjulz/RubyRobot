require "spec_helper"

module RubyRobot
  describe Direction do
    describe "initialize(location, facing_direction, surface)" do
      it "Retrieves the correct constant (String)" do
        expect(Direction["North"]).to eq(Direction::NORTH)
        expect(Direction["south"]).to eq(Direction::SOUTH)
        expect(Direction["North"]).not_to eq(Direction::SOUTH)
      end
      it "Retrieves the correct constant (Symbol)" do
        expect(Direction[:north]).to eq(Direction::NORTH)
        expect(Direction[:South]).to eq(Direction::SOUTH)
        expect(Direction[:North]).not_to eq(Direction::SOUTH)
      end
      it "Retrieves the correct constant (Symbol)" do
        expect(Direction[0]).to eq(Direction::NORTH)
        expect(Direction[90]).to eq(Direction::EAST)
        expect(Direction[180]).to eq(Direction::SOUTH)
        expect(Direction[270]).to eq(Direction::WEST)
        expect(Direction[360]).to eq(Direction::NORTH)
        expect(Direction[450]).to eq(Direction::EAST)
        expect(Direction[-90]).to eq(Direction::WEST)
        expect(Direction[-450]).to eq(Direction::WEST)
        expect(Direction[0]).not_to eq(Direction::SOUTH)
        expect{Direction[12]}.to raise_error(OutOfBoundaryError)
      end
    end
  end
end
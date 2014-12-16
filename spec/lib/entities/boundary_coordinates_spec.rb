require "spec_helper"

module RubyRobot
  describe BoundaryCoordinates do
    describe "#initialize" do
      it "creates the object" do
        bc = BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(5,5))
        expect(bc).not_to eq(nil)
      end

      it "raises boundary errors" do
        expect{BoundaryCoordinates.new(Coordinate.new(6,0), Coordinate.new(5,5))}.to raise_error(OutOfBoundaryError)
        expect{BoundaryCoordinates.new(Coordinate.new(0,6), Coordinate.new(5,5))}.to raise_error(OutOfBoundaryError)
        expect{BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(-1,5))}.to raise_error(OutOfBoundaryError)
        expect{BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(5,-1))}.to raise_error(OutOfBoundaryError)
      end
    end
    
    describe "#within_bounds?" do
      let (:bc) {BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(4,5))}
      it "is within bounds" do
        expect(bc.within_bounds?(Coordinate.new(0,0))).to eq(true)
        expect(bc.within_bounds?(Coordinate.new(4,0))).to eq(true)
        expect(bc.within_bounds?(Coordinate.new(0,5))).to eq(true)
        expect(bc.within_bounds?(Coordinate.new(4,5))).to eq(true)
      end

      it "is outside bounds" do
        expect(bc.within_bounds?(Coordinate.new(-1,-1))).to eq(false)
        expect(bc.within_bounds?(Coordinate.new(-1,0))).to eq(false)
        expect(bc.within_bounds?(Coordinate.new(0,-1))).to eq(false)
        expect(bc.within_bounds?(Coordinate.new(5,0))).to eq(false)
        expect(bc.within_bounds?(Coordinate.new(0,6))).to eq(false)
        expect(bc.within_bounds?(Coordinate.new(5,6))).to eq(false)
      end
    end
  end
end
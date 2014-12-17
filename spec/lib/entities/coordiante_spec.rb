require "spec_helper"

module RubyRobot
  describe Coordinate do
    describe "#initialize" do
      let(:coord) {Coordinate.new(1, 2)}
      it "Stores the values" do
        expect(coord.x).to eq(1)
        expect(coord.y).to eq(2)
      end
    end
    
    describe "#+()" do
      let(:coord) {Coordinate.new(1, 2)}
      let(:coord2) {Coordinate.new(4, 6)}
      it "correctly calculates" do
        calcValue = coord + coord2
        expect(calcValue.x).to eq(5)
        expect(calcValue.y).to eq(8)

        expect(coord.x).to eq(1)
        expect(coord.y).to eq(2)
        
        expect(coord2.x).to eq(4)
        expect(coord2.y).to eq(6)
      end
    end

    describe "#-()" do
      let (:coord) {Coordinate.new(1, 2)}
      let (:coord2) {Coordinate.new(4, 6)}
      it "correctly calculates" do
        calcValue = coord - coord2
        expect(calcValue.x).to eq(-3)
        expect(calcValue.y).to eq(-4)

        expect(coord.x).to eq(1)
        expect(coord.y).to eq(2)
        
        expect(coord2.x).to eq(4)
        expect(coord2.y).to eq(6)
      end
    end


    describe "#==()" do
      let(:coord) {Coordinate.new(1, 2)}
      let(:coord2) {Coordinate.new(4, 4)}
      let(:coord3) {Coordinate.new(2, 1)}
      let(:coord4) {Coordinate.new(1, 2)}
      it "correctly calculates" do
        expect(coord == coord2).to eq(false)
        expect(coord == coord3).to eq(false)
        expect(coord == coord4).to eq(true)
        expect(coord == coord).to eq(true)
      end
    end
    
    describe "#to_s" do
      let(:coord) {Coordinate.new(1, 2)}
      let(:coord2) {Coordinate.new(4, 4)}
      let(:coord3) {Coordinate.new(2, 1)}
      it "correctly calculates" do
        expect(coord.to_s).to eq("[1,2]")
        expect(coord2.to_s).to eq("[4,4]")
        expect(coord3.to_s).to eq("[2,1]")
      end
    end
  end
end
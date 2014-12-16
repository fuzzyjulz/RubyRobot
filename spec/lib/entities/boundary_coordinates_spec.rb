require "spec_helper"

describe RubyRobot::BoundaryCoordinates do
  describe "#initialize" do
    it "creates the object" do
      bc = BoundaryCoordinates.new(Coordinate.new(0,0), Coordinate.new(5,5))
      expect(bc).to !eq(nil)
      binding.pry
    end
  end
  
  describe "#within_bounds?" do
    it "" do
      
    end
  end
end

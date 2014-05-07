require 'spec_helper'

describe Ecc do
  c = Ecc.new

  describe "get_p_sieves" do  
    it "test 11" do        
      c.p = 11
      c.get_p_sieves.to_set.should == [1, 3, 4, 5, 9].to_set
    end

    it "test 7" do        
      c.p = 7
      c.get_p_sieves.to_set.should == [1, 2, 4].to_set
    end
  end

  describe "get_eliptic_group_points" do
    it "" do
    end
  end
end
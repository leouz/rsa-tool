require 'spec_helper'

describe MathHelper do
  it "get primes until 10" do
  	helper.get_primes_until(10).to_set.should == [2, 3, 5, 7].to_set
  end

  it "get primes until 100" do
  	helper.get_primes_until(10).to_set.should == [2, 3, 5, 7].to_set
  end

  it "factor 10" do
  	helper.factor(10).to_set.should == [2, 5].to_set
  end

  it "factor 20" do
  	helper.factor(20).to_set.should == [2, 5].to_set
  end

  it "factor 30" do
  	helper.factor(20).to_set.should == [2, 5].to_set
  end
end
require 'spec_helper'

test_inputs = [
	{ p: 3, q: 13, n: 65, z: 48, e: 7, d: 55 }
  # { p: 3, q: 11, n: 33, z: 20, e: 7, d:  3 }
  
]

test_inputs.each { |input| 
	describe Crypto do
		c = Crypto.new

		# before(:all) do    	
			e_possibilities = c.get_e_possibilities input[:p], input[:q]
			d = c.get_d input[:e] 
  	# end 

		describe "part 1" do
			# it "test e_possibilities" do			
			# 	e_possibilities.to_set.should == [5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47].to_set
			# end

		  it "test n" do  	  	
		  	c.n_public_key.should == input[:n]
		  end

		  it "test z" do
		  	c.z.should == input[:z]
		  end
		end

		describe "part 2" do
			

			# it "e is in e_possibilities" do
			# 	e_possibilities
			# end

			it "test get_d" do			
				d.should == input[:d]
			end

		  it "test e" do  	  	
		  	c.e_public_key.should == input[:e]
		  end
		end

		# (10..20).each{ |number|
		# 	describe "encryption for number -> #{number}" do
		# 		encryption_result = c.encrypt_number number		
		# 		decryption_result = c.decrypt_number encryption_result

		# 		it "test encryption" do
		# 			encryption_result.should_not == number
		# 			encryption_result.should_not == nil
		# 		end

		# 		it "test decryption" do					
		# 			decryption_result.should == number
		# 		end
		# 	end
		# }

		# describe "encryption for number -> 14" do
		# 	number = 14
		# 	encryption_result = c.encrypt_number number		

		# 	it "test encryption" do
		# 		encryption_result.should_not == number
		# 		encryption_result.should_not == nil
		# 	end

		# 	it "test decryption" do
		# 		decryption_result = c.decrypt_number encryption_result
		# 		decryption_result.should == number
		# 	end
		# end

		("a".."z").each{ |char|
			describe "encryption for char '#{char}'" do
				encryption_result = c.encrypt_char char		
				decryption_result = c.decrypt_char encryption_result

				it "test encryption" do
					encryption_result.should_not == char
					encryption_result.should_not == nil
				end

				it "test decryption" do					
					decryption_result.should == char
				end
			end
		}

	end
}

# describe "calc number" do
# 	c = Crypto.new

# 	it "14 7 33" do
# 		c.calc_number(14, 7, 33).should == 20
# 	end

# 	it "20 3 33" do
# 		c.calc_number(20, 3, 33).should == 14
# 	end
# end
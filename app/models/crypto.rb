require 'prime'

class Crypto
	attr_accessor :p, :q, :n_public_key, :z, :e_public_key, :d_secret_key

	#generate key part 1

	def get_e_possibilities p, q
		@p, @q = p, q
		@n_public_key = @p * @q
		@z = (@p - 1) * (@q - 1)

		(get_primes_until(@z) - factor(@z)) - [2]
	end

	def get_primes_until input
		Prime.take_while { |p| p < input } - [2]
	end

	def factor input
		Prime.prime_division(input).map{ |k, v| k }
	end

	#generate key part 2

	def get_d e
		@e_public_key = e
		current_mod_z = nil

		begin
			current_mod_z = current_mod_z ? (current_mod_z + @z) : @z
			@d_secret_key = (current_mod_z + 1) / @e_public_key
			division_mod = (current_mod_z + 1) % @e_public_key
	  end while not (division_mod == 0 and @e_public_key != @d_secret_key)

		@d_secret_key
	end

	def extended_gcd(a, b)
	  return [0,1] if a % b == 0
	  x,y = extended_gcd(b, a % b)
	  [y, x-y*(a / b)]
	end

	#encrypt number

	def encrypt_number input
		calc_number input, @e_public_key, @n_public_key
	end

	def decrypt_number input
		calc_number input, @d_secret_key, @n_public_key
	end

	def calc_number(input, key, mod_key)
		pow = input ** key		
		pow - ((pow / mod_key).floor * mod_key)
	end

	#encrypt char
	
	def encrypt_char input
		encrypt_number(char_to_bignum(input))
	end

	def decrypt_char input
		bignum_to_char(decrypt_number(input))
	end

	def char_to_bignum input
		r = 0
  	input.each_byte{ |b| r = r * 256 + b }
  	r
	end

	def bignum_to_char input
	  r = ""
	  while input > 0
	    r = (input&0xff).chr + r
	    input >>= 8
	  end
	  r	
	end

	#encrypt

	def encrypt input		
		r = ""		
		input.split("").each do |i|			
  		r << encrypt_char(i).to_s.ljust(8)
		end
		r
	end

	def decrypt input		
		r = ""		
		input.chars.each_slice(8).each do |i|			
  		r << decrypt_char(i.join("").strip.to_i)
		end
		r
	end
end
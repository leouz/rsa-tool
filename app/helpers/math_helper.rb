require 'prime'

module MathHelper
	def get_primes_until input
		Prime.take_while { |p| p < input }
	end

	def factor input
		Prime.prime_division(input).map{ |k, v| k }
	end
end

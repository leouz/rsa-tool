class Common
  def self.get_primes_until input
    Prime.take_while { |p| p < input } - [2]
  end

  def self.factor input
    Prime.prime_division(input).map{ |k, v| k }
  end
end
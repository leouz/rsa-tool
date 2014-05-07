require 'prime'

class Ecc

  class ElipticGroups
    attr_accessor :result

    def initialize p, a, b
      @p, @a, @b = p, a, b
      
      @result = []

      calculate_sieves

      calculate_eliptic_groups
    end    

    def calculate_sieves
      multiples = (1...@p).map{ |i| i * @p }
      powers = (1...@p).map{ |i| i * i }    
          
      (1...@p).each do |i| 
        @result << { :sieve => i } if multiples.any?{ |m| powers.any?{ |p| (i + m) == p } }
      end    
    end

    def calculate_eliptic_groups
      @result.each do |r|
        x = r[:sieve]

        # y²=x³+ax+b mod p
        point = Math.sqrt((x ** 3) + (@a * x) + @b)
        
        r[:point] = point
        r[:y1] = Float(point % @p)
        r[:y2] = Float((-point). % @p)
        r[:is_valid] = (r[:y1] % 1 == 0 and r[:y2] % 1 == 0)
      end
    end
  end

  class SumDiff
    attr_accessor :result, :message

    def initialize p, a, x1=nil, y1=nil, x2=nil, y2=nil
      @p, @a, @x1, @y1, @x2, @y2 = p, a, x1, y1, x2, y2
    end

    def calculate_lambda
      if @x1 == @x2 and @y1 == @y2                    
        div1 = (3.0 * (@x1 ** 2.0) + @a)
        div2 = (2.0 * @y1)        
      else
        div1 = (@y2 - @y1)
        div2 = (@x2 - @x1)
      end   

      if div1 == 0 or div2 == 0
        @message, @x3, @y3 = "infinity point", nil, nil
        false
      else
        @lambda = div1 / div2
        true
      end
    end

    def get_sum
      if calculate_lambda
        if @lambda % 1 != 0 
          @message, @x3, @y3 = "can't do it", nil, nil
        else
          @x3 = ((@lambda ** 2.0) - @x1 - @x2) % @p
          @y3 = ((@lambda * (@x1 - @x3)) - @y1) % @p
          @message = "ok"
        end
      end
      
      result
    end

    def get_sum_static x1, y1, x2, y2
      @x1, @y1, @x2, @y2 = x1, y1, x2, y2      
      
      get_sum
    end

    def result
      { :p => @p, :a => @a, :x1 => @x1, :y1 => @y1, :x2 => @x2, :y2 => @y2, 
        :x3 => @x3, :y3 => @y3,
        :lambda => @lambda, :message => @message }
    end

    def get_diff
      @y2 = @p - @y2

      get_sum
    end
  end

  class Product
    attr_accessor :result

    def initialize x1, y1, p, a, n
      @x1, @y1, @p, @a, @n = x1, y1, p, a, n      
      @sum = SumDiff.new @p, @a
      @log = []
      calculate_binary
      calculate_sums
      calculate_product
    end    
    
    def calculate_binary
      remainder = @n
      i = 0
      @binary = []

      while i < 4       
        @binary[i] = (remainder % 2).floor
        remainder = remainder / 2
        i += 1
      end 

      @binary_reverse = @binary.reverse
    end

    def calculate_sums
      @sums = []
      @sums[0] = [ @x1, @y1 ]
      @sums[1] = do_sum @x1, @y1      
      if @sums[1] and @sums[1][0] and @sums[1][1]
        @sums[2] = do_sum @sums[1][0], @sums[1][1] 

        if @sums[2] and @sums[2][0] and @sums[2][1]
          @sums[3] = do_sum @sums[2][0], @sums[2][1] 
        end
      end
    end

    def calculate_product
      i = 0
      
      if @sums[1] and @sums[2] and @sums[3]
        while i < 4
          i += 1
          if @binary_reverse[i] == 1 and @product
            @product = do_sum @product[0], @product[1], @sums[i][0], @sums[i][1]
          else
            @product = @sums[i]
          end
        end
      end
    end

    def do_sum x1, y1, x2 = nil, y2 = nil      
      if x2 and y2 
        r = @sum.get_sum_static x1, y1, x2, y2         
      else
        r = @sum.get_sum_static x1, y1, x1, y1
      end
      @log << r

      [ r[:x3], r[:y3] ]
    end

    def result
      { :binary => @binary, 
        :binary_reverse => @binary_reverse, 
        :sums => @sums, 
        :product => @product, 
        :log => @log }
    end
  end

end
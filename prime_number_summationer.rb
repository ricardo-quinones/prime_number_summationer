require 'benchmark'

class PrimeNumberSummationer
  attr_accessor :prime_number_sum

  def calculate(nth_prime_number)
    Benchmark.bm do |x|
      x.report { using_array(nth_prime_number) }
    end

    prime_number_sum
  end

  def using_array(nth_prime_number)
    self.prime_number_sum = 2
    return if nth_prime_number == 1

    max = nth_prime_number * 11
    odd_numbers = (3..max).step(2).to_a
    prime_number_count = 1

    loop do
      new_prime = odd_numbers.shift
      prime_number_count += 1
      self.prime_number_sum += new_prime

      break if prime_number_count == nth_prime_number

      odd_numbers -= ((new_prime ** 2)..max).step(new_prime).to_a
    end
  end
end

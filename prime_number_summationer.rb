require 'benchmark'

class PrimeNumberSummationer
  attr_accessor :prime_number_sum, :prime_number_count, :upper_bound, :odd_numbers

  def calculate(nth_prime_number)
    Benchmark.bm do |x|
      x.report { _calculate(nth_prime_number) }
    end

    prime_number_sum
  end

  private

  def _calculate(nth_prime_number)
    initialize_calculator(nth_prime_number)
    return if nth_prime_number < 1

    odd_numbers.each do |number|
      next unless number
      break if (self.prime_number_count += 1) == nth_prime_number

      (number ** 2).step(upper_bound, number * 2) do |non_prime|
        odd_numbers[(non_prime - 1) / 2 - 1] = nil
      end
    end

    self.prime_number_sum = 2 + odd_numbers.compact.take(nth_prime_number - 1).inject(:+).to_i
  end

  def initialize_calculator(nth_prime_number)
    self.prime_number_count = 0
    self.prime_number_sum = 0
    self.upper_bound = approximate_upper_bound(nth_prime_number)
    self.odd_numbers = (3..upper_bound).step(2).to_a
  end

  def approximate_upper_bound(nth_prime_number)
    return 14 if nth_prime_number < 6
    (1.05 * nth_prime_number * (Math.log(nth_prime_number) + Math.log(Math.log(nth_prime_number)))).ceil
  end
end

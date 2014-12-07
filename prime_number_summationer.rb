require 'benchmark'

class PrimeNumberSummationer
  attr_accessor :prime_number_sum, :prime_number_count, :max_odd_number, :odd_numbers, :index_to_take, :primes_left

  def calculate(nth_prime_number)
    Benchmark.bm do |x|
      x.report { _calculate(nth_prime_number) }
    end

    prime_number_sum
  end

  private

  def _calculate(nth_prime_number)
    initialize_calculator(nth_prime_number)
    return if nth_prime_number == 1

    loop do
      if can_break_loop?(nth_prime_number)
        new_primes = odd_numbers[0...primes_left]
        # Delete the square of the first prime number in the array if present
        new_primes.delete(new_primes.first ** 2)
        self.prime_number_sum += new_primes.inject(:+)
        break
      end

      new_prime = odd_numbers.shift
      self.prime_number_count += 1
      self.prime_number_sum += new_prime

      self.odd_numbers -= ((new_prime ** 2)..max_odd_number).step(new_prime).to_a
    end
  end

  def initialize_calculator(nth_prime_number)
    self.prime_number_sum = 2
    self.max_odd_number = calculate_upper_bound(nth_prime_number)
    self.odd_numbers = (3..max_odd_number).step(2).to_a
    self.prime_number_count = 1
  end

  def calculate_upper_bound(nth_prime_number)
    return 14 if nth_prime_number < 6
    (1.05 * nth_prime_number * (Math.log(nth_prime_number) + Math.log(Math.log(nth_prime_number)))).ceil
  end

  def can_break_loop?(nth_prime_number)
    # Will include square of first number in array
    self.index_to_take = odd_numbers.find_index { |num| num > odd_numbers.first ** 2 } + 1
    self.primes_left = nth_prime_number - prime_number_count

    return index_to_take - 1 >= primes_left
  end
end

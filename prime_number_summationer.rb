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
    prime_numbers = []

    loop do
      # Will include square of first number in array
      index_to_take = odd_numbers.find_index { |num| num > odd_numbers.first ** 2 } + 1
      primes_left = nth_prime_number - prime_number_count

      if index_to_take - 1 >= primes_left
        new_primes = odd_numbers[0...primes_left]
        # Delete the square of the first prime number in the array if present
        new_primes.delete(new_primes.first ** 2)
        self.prime_number_sum += new_primes.inject(:+)
        break
      end

      new_prime = odd_numbers.shift
      prime_number_count += 1
      prime_numbers << new_prime
      self.prime_number_sum += new_prime

      odd_numbers -= ((new_prime ** 2)..max).step(new_prime).to_a
    end
  end
end

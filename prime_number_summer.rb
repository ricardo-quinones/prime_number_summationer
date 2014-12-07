require_relative 'prime_number_summationer'

prime_number_summationer = PrimeNumberSummationer.new

loop do
  puts "Enter the nth prime number you would like to sum to:"
  number = gets.chomp

  if number =~ /\d+/
    number = number.to_i
    if number.between?(0, 10001)
      puts prime_number_summationer.calculate(number)
    else
      puts "Sorry. That is out of the allowable range. Please input a number less than or equal to 10,000."
    end
  else
    puts "That is not a integer. Please input an integer."
  end
end
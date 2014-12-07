require './prime_number_summationer'

describe PrimeNumberSummationer do
  let(:prime_number_summationer) { PrimeNumberSummationer.new }

  describe "#calculate" do
    it "correctly calculates the first prime number" do
      expect(prime_number_summationer.calculate(1)).to eq(2)
    end

    it "correctly calculates up to 2 prime numbers" do
      expect(prime_number_summationer.calculate(2)).to eq(5)
    end

    it "correctly calculates up to 9 prime numbers" do
      expect(prime_number_summationer.calculate(9)).to eq(100)
    end

    it "correctly calculates up to 1000 prime numbers" do
      expect(prime_number_summationer.calculate(1000)).to eq(3682913)
    end
  end
end
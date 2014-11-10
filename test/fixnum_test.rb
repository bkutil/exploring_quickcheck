require 'test_helper'
require_relative '../lib/fixnum_helper'

class FixNumTest < Minitest::Test
  def test_odd_even_raw
    property_of { integer }.check { |i| assert(i.even? ? (i + 1).odd? : true) }
  end

  def test_odd_even
    property_of { i = integer; guard i.even?; i }.check { |i| assert (i + 1).odd? }
  end

  def test_mersenne
    property_of { i = range(0, 20); guard i.prime?; i }.check { |i| assert (2**i - 1).prime? }
  end

  def test_mersenne_raw
    property_of { range(0, 20) }.check { |i| assert(i.prime? ? (2**i - 1).prime? : true) }
  end

  def test_collatz
    property_of { i = integer; guard i > 0; i }.check { |i| assert(i.collatz_holds?) }
  end

  def test_collatz_generator
    # Generator for random positive integers
    positives = Enumerator.new do |y|
      loop do
        y.yield rand((1..Rantly::INTEGER_MAX))
      end
    end

    property_of { positives.next }.check { |i| assert(i.collatz_holds?) }
  end

  def test_collatz_abs
    property_of do
      x = integer
      if x == 0
        1
      elsif x < 0
        -x
      else
        x
      end
    end.check { |i| assert(i.collatz_holds?) }
  end

  def test_not_product
    # FIXME: check how QuickCheck proceeds in generating the test cases
    # as it seems to start from smaller ints/records instead of purely random
    # integers as with rantly
    property_of { [range(1,10), range(1, 10)] }.check { |x, y| assert(10.not_product(x, y)) }
  end
end

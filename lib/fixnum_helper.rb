class Fixnum
  def divides?(n)
    n % self == 0
  end

  def prime?
    if self <= 1
      false
    elsif self == 2
      true
    else
      (2..self-1).none? { |i| i.divides?(self) }
    end
  end

  def collatz_holds?
    n = self

    return true if n == 1

    while n > 1
      if n.even?
        n /= 2
      else
        n = 3 * n + 1
      end
    end

    return n == 1
  end

  def not_product(x, y)
    self != x * y || x == 1 || y == 1
  end
end

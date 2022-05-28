class Solver
  def factorial(num)
    return "Please use a positive number" if num < 0
    return 1 if num == 0
    return num * factorial(num-1)
  end
end
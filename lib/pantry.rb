class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(item)
    stock.default = 0
    stock[item]
  end

  def restock(item, amount)
    if stock[item] != 0
      stock[item] = stock[item] + amount
    else
      stock[item] = amount
    end
  end
end

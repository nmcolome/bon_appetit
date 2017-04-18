require './lib/recipe'

class Pantry
  attr_reader :stock, :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
  end

  def stock_check(item)
    stock.default = 0
    stock[item]
  end

  def restock(item, amount)
    if !stock[item].nil?
      stock[item] = stock[item] + amount
    else
      stock[item] = amount
    end
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |item, amount|
      if !shopping_list[item].nil?
        shopping_list[item] = shopping_list[item] + amount
      else
        shopping_list[item] = amount
      end
    end
  end

  def print_shopping_list
    
  end

end

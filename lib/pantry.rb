require './lib/recipe'

class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
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
    nothing = String.new
    shopping_list.each do |item, amount|
      nothing << "* #{item}: #{amount}\n"
    end
    nothing.chop
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    options = []
    cookbook.each do |recipe|
      enough_amounts = []
      recipe.ingredients.each do |item, amount|
        if amount <= stock[item]
          enough_amounts << true
        else
          enough_amounts << false
        end
      end
      add_options(options,recipe, enough_amounts)
    end
    options
  end

  # def check_amounts(item, amount)
    
  # end

  def add_options(options,recipe, enough_amounts)
    options << recipe.name if enough_amounts.all? { |is_there| is_there == true } 
  end

  def how_many_i_can_make
    
  end
end
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
      check_if_recipe_is_an_option(recipe, options)
    end
    options
  end

  def check_if_recipe_is_an_option(recipe, options)
    enough_amounts = []
    recipe.ingredients.each do |item, amount|
      check_amounts(item, amount, enough_amounts)
    end
    add_options(options,recipe, enough_amounts)
  end

  def check_amounts(item, amount, enough_amounts)
    if amount <= stock[item]
      enough_amounts << true
    else
      enough_amounts << false
    end
  end

  def add_options(options,recipe, enough_amounts)
    if enough_amounts.all? { |is_there| is_there == true }
      options << recipe.name 
    end
  end

  def how_many_can_i_make
    how_many = {}
    binding.pry
    what_can_i_make.each do |recipe|
      cookbook.each do |recipe_obj|
        if recipe_obj.name == recipe
        times = []
        cookbook.ingredients.each do |item, amount|
          times << (stock[item] / amount)
        end
        how_many[recipe] = times.min
      end
    end
  end
  
  end
end
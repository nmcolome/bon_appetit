require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test

  def setup
    @pantry = Pantry.new
    @r = Recipe.new("Cheese Pizza")
    @r.add_ingredient("Cheese", 20)
    @r.add_ingredient("Flour", 20)

    @r_2 = Recipe.new("Spaghetti")
    @r_2.add_ingredient("Noodles", 10)
    @r_2.add_ingredient("Sauce", 10)
    @r_2.add_ingredient("Cheese", 5)

    @r1 = Recipe.new("Cheese Pizza")
    @r1.add_ingredient("Cheese", 20)
    @r1.add_ingredient("Flour", 20)

    @r2 = Recipe.new("Pickles")
    @r2.add_ingredient("Brine", 10)
    @r2.add_ingredient("Cucumbers", 30)

    @r3 = Recipe.new("Peanuts")
    @r3.add_ingredient("Raw nuts", 10)
    @r3.add_ingredient("Salt", 10)
  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_when_initialized_stock_is_empty
    assert_instance_of Hash, @pantry.stock
    assert @pantry.stock.empty?
  end

  def test_it_can_check_whats_in_pantry
    assert_equal 0, @pantry.stock_check("Cheese")
  end

  def test_it_can_restock_pantry
    @pantry.restock("Cheese", 10)
    assert_equal 10, @pantry.stock_check("Cheese")

    @pantry.restock("Cheese", 20)
    assert_equal 30, @pantry.stock_check("Cheese")
  end

  def test_generation_of_shopping_list_for_existing_recipes
    @pantry.add_to_shopping_list(@r)

    output = {"Cheese" => 20, "Flour" => 20}
    assert_equal output, @pantry.shopping_list
  end

  def test_shopping_list_with_same_ingredients_for_different_recipes
    @pantry.add_to_shopping_list(@r)
    @pantry.add_to_shopping_list(@r_2)
    
    output = {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}
    assert_equal output, @pantry.shopping_list
  end

  def test_it_can_print_shopping_list
    @pantry.add_to_shopping_list(@r)
    @pantry.add_to_shopping_list(@r_2)
    
    output = "* Cheese: 25\n* Flour: 20\n* Noodles: 10\n* Sauce: 10"
    assert_equal output, @pantry.print_shopping_list
  end

  def test_it_can_add_recipes_to_cookbook
    @pantry.add_to_cookbook(@r1)
    @pantry.add_to_cookbook(@r2)
    @pantry.add_to_cookbook(@r3)

    assert_instance_of Recipe, @pantry.cookbook.first
    assert_equal "Cheese Pizza", @pantry.cookbook.first.name
    ingredients = {"Cheese"=>20, "Flour"=>20}
    assert_equal ingredients, @pantry.cookbook.first.ingredients
  end

  def test_it_returns_what_I_can_make_with_ingredients_i_already_have
    @pantry.add_to_cookbook(@r1)
    @pantry.add_to_cookbook(@r2)
    @pantry.add_to_cookbook(@r3)

    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Cucumbers", 40)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)

    expected = ["Pickles", "Peanuts"]
    assert_equal expected, @pantry.what_can_i_make
  end
end

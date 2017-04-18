require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test

  def setup
    @pantry = Pantry.new
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
end

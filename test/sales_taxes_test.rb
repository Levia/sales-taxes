require_relative '../lib/item'
require_relative '../lib/sales_taxes'
require 'test/unit'

class SalesTaxesTest < Test::Unit::TestCase

  def setup
    @items = []
  end

  def test_input_1
    @items << Item.new(1, 'book', :books, 12.49)
    @items << Item.new(1, 'music CD', :music, 14.99)
    @items << Item.new(1, 'chocolate bar', :food, 0.85)

    result = SalesTaxes.new(@items).run
    expected_output = { taxes: 1.50, total: 29.83 }

    assert_equal @items[0].total_price, 12.49
    assert_equal @items[1].total_price, 16.49
    assert_equal @items[2].total_price, 0.85
    assert_equal result, expected_output
  end

  def test_input_2
    @items << Item.new(1, 'box of chocolates', :food, 10.00, true)
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 47.50, true)

    result = SalesTaxes.new(@items).run
    expected_output = { taxes: 7.65, total: 65.15 }

    assert_equal @items[0].total_price, 10.50
    assert_equal @items[1].total_price, 54.65
    assert_equal result, expected_output
  end

  def test_input_3
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 27.99, true)
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 18.99)
    @items << Item.new(1, 'packet of headache pills', :medical, 9.75)
    @items << Item.new(1, 'box of imported chocolates', :food, 11.25, true)

    result = SalesTaxes.new(@items).run
    expected_output = { taxes: 6.70, total: 74.68 }

    assert_equal @items[0].total_price, 32.19
    assert_equal @items[1].total_price, 20.89
    assert_equal @items[2].total_price, 9.75
    assert_equal @items[3].total_price, 11.85
    assert_equal result, expected_output
  end

  def test_input_with_multiple_occurrences_of_same_product
    @items << Item.new(2, 'box of chocolates', :food, 10.00, true)
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 47.50, true)

    result = SalesTaxes.new(@items).run
    expected_output = { taxes: 8.15, total: 75.65 }

    assert_equal @items[0].total_price, 21.00
    assert_equal @items[1].total_price, 54.65
    assert_equal result, expected_output
  end

  def test_more_complex_input
    @items << Item.new(2, 'bottle of perfume', :cosmetics, 27.99, true)
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 18.99)
    @items << Item.new(3, 'packet of headache pills', :medical, 9.75)
    @items << Item.new(4, 'box of imported chocolates', :food, 11.25, true)

    result = SalesTaxes.new(@items).run
    expected_output = { taxes: 12.7, total: 161.92 }

    assert_equal @items[0].total_price, 64.38
    assert_equal @items[1].total_price, 20.89
    assert_equal @items[2].total_price, 29.25
    assert_equal @items[3].total_price, 47.4
    assert_equal result, expected_output
  end
end


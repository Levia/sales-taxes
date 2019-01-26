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
    expected_output = "1 book: 12.49\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 29.83"

    assert_equal @items[0].total_price, 12.49
    assert_equal @items[1].total_price, 16.49
    assert_equal @items[2].total_price, 0.85
    assert_equal result, expected_output
  end

  def test_input_2
    @items << Item.new(1, 'box of chocolates', :food, 10.00, true)
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 47.50, true)

    result = SalesTaxes.new(@items).run
    expected_output = "1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15"

    assert_equal @items[0].total_price, 10.50
    assert_equal @items[1].total_price, 54.65
    assert_equal result, expected_output
  end

  def test_input_3
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 27.99, true)
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 18.99)
    @items << Item.new(1, 'packet of headache pills', :medical, 9.75)
    @items << Item.new(1, 'box of chocolates', :food, 11.25, true)

    result = SalesTaxes.new(@items).run
    expected_output = "1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n1 imported box of chocolates: 11.85\nSales Taxes: 6.70\nTotal: 74.68"

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
    expected_output = "2 imported box of chocolates: 21.00\n1 imported bottle of perfume: 54.65\nSales Taxes: 8.15\nTotal: 75.65"

    assert_equal @items[0].total_price, 21.00
    assert_equal @items[1].total_price, 54.65
    assert_equal result, expected_output
  end

  def test_more_complex_input
    @items << Item.new(2, 'bottle of perfume', :cosmetics, 27.99, true)
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 18.99)
    @items << Item.new(3, 'packet of headache pills', :medical, 9.75)
    @items << Item.new(4, 'box of chocolates', :food, 11.25, true)

    result = SalesTaxes.new(@items).run
    expected_output = "2 imported bottle of perfume: 64.38\n1 bottle of perfume: 20.89\n3 packet of headache pills: 29.25\n4 imported box of chocolates: 47.40\nSales Taxes: 12.70\nTotal: 161.92"

    assert_equal @items[0].total_price, 64.38
    assert_equal @items[1].total_price, 20.89
    assert_equal @items[2].total_price, 29.25
    assert_equal @items[3].total_price, 47.4
    assert_equal result, expected_output
  end
end


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

    assert_equal result, expected_output
  end

  def test_input_2
    @items << Item.new(1, 'box of chocolates', :food, 10.00, true)
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 47.50, true)

    result = SalesTaxes.new(@items).run
    expected_output = { taxes: 7.65, total: 65.15 }

    assert_equal result, expected_output
  end

  def test_input_3
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 27.99, true)
    @items << Item.new(1, 'bottle of perfume', :cosmetics, 18.99)
    @items << Item.new(1, 'packet of headache pills', :medical, 9.75)
    @items << Item.new(1, 'box of imported chocolates', :food, 11.25, true)

    result = SalesTaxes.new(@items).run
    expected_output = { taxes: 6.70, total: 74.68 }

    assert_equal result, expected_output
  end
end


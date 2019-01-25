class Item
  attr_reader :amount, :name, :type, :price, :is_imported, :taxes, :total_price

  TAXES = {
    goods: 0.1,
    import: 0.05
  }.freeze

  EXCEPTIONS = [:books, :food, :medical]

  def initialize(amount, name, type, price, is_imported=false)
    @amount = amount
    @name = name
    @type = type
    @price = price
    @is_imported = is_imported
    @taxes = calculate_taxes
    @total_price = calculate_total
  end

  private

  def calculate_taxes
    taxes = EXCEPTIONS.include?(@type) ? 0.0 : TAXES[:goods]
    taxes += TAXES[:import] if is_imported

    # * 20 and then / 20.0 rounds up to the nearest 0.05
    # as 0.05 is equal to 1/20 and the general formula is x * [y/x]
    # where y is the number to round, x is 0.05 and [y/x] is the smallest integer
    # greater than or equal to y/x
    ((@price * taxes) * @amount * 20).ceil / 20.0
    # So the above formula could also be written as
    #(0.05 * ((@price * taxes * @amount) / 0.05).ceil)
  end

  def calculate_total
    (@price + @taxes).round(2)
  end
end

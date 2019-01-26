class SalesTaxes
  def initialize(items)
    @items = items
    @taxes = 0.0
    @total = 0.0
  end

  def run
    @taxes = calculate_taxes
    @total = calculate_total_price
    p get_receipt
  end

  private

  [:taxes, :total_price].each do |name|
    define_method("calculate_#{name}") do |*args|
      @items.inject(0) { |sum, item| sum + item.send(name) }.round(2)
    end
  end

  def get_receipt
    receipt = @items.map(&:receipt_line)
    receipt << "Sales Taxes: #{'%.2f' % @taxes}"
    receipt << "Total: #{'%.2f' % @total}"
    receipt.join("\n")
  end
end

require "pry"

class CashRegister
  attr_reader :items
  attr_accessor :discount, :total

  def initialize(discount = 0)
    @discount = discount
    @items = []
    @total = 0
    @last_item = {
        :title => "",
        :price => 0,
        :quantity => 0
    }
  end

  def add_item(title, price, quantity = 1)
    quantity.times {|num| @items.push(title)}
    @last_item[:title] = title
    @last_item[:price] = price
    @last_item[:quantity] = quantity
    self.total = self.total + (price * quantity)
  end

  def apply_discount
    if discount == 0
      "There is no discount to apply."
    else
      self.total = (self.total - (self.total * (self.discount / 100.0))).to_int
      "After the discount, the total comes to $#{self.total}."
    end
  end

  def void_last_transaction
    self.total = self.total - (@last_item[:price] * @last_item[:quantity])
    @last_item[:quantity].times {|num| @items.pop}
    self.total
  end
end

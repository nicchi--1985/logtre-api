class TradeSummary
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :period, :plus_benefit, :minus_benefit

  def initialize(period, plus_benefit, minus_benefit, product_type)
    @period = period
    @plus_benefit = plus_benefit
    @minus_benefit = minus_benefit
    @product_type = product_type
  end

  def attributes
    {
      'period' => nil,
      'plus_benefit' => nil,
      'minus_benefit' => nil,
      'product_type' => nil
    }
  end
end

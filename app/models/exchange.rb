class Exchange < ActiveRecord::Base
  has_many  :trades, as: :tradable

  def self.find_or_create(params)
    @exchange = Exchange.where(
        base_currency: params[:base_currency],
        quote_currency: params[:quote_currency]
      ).first_or_create
    return @exchange
  end
end

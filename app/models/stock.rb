class Stock < ActiveRecord::Base
  has_many  :trades, as: :tradable

  def self.find_or_create(params)
    @stock = Stock.where(brand_code: params[:brand_code]).first_or_create
    return @stock
  end
end

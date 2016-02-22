class Option < ActiveRecord::Base
  has_many  :trades, as: :tradable

  def self.find_or_create(params)
    @option = Option.where(
        index_code: params[:index_code],
        exercise_price: params[:exercise_price],
        year: params[:year],
        month: params[:month]
      ).first_or_create
    return @option
  end
end

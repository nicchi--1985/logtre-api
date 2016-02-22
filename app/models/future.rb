class Future < ActiveRecord::Base
  has_many  :trades, as: :tradable

  def self.find_or_create(params)
    @future = Future.where(
        index_code: params[:index_code],
        year: params[:year],
        month: params[:month]
      ).first_or_create
    return @future
  end
end

class TradeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :action_type, :forecast, :tradable_type, :invest_amount, \
  :invest_quantity, :implimentation_date, :benefit_amount, :change_rate, :benefit_rate
  has_one :tradable
  has_many :bases

  def action_type
    if object.action_type == ActionTypeEnum::BUY
      if object.forecast == false
        "買い"
      else
        "買い予想"
      end
    elsif object.action_type == ActionTypeEnum::SELL
      if object.forecast == false
        "売り"
      else
        "売り予想"
      end
    end
  end

  def tradable_type
    productDict = {"Stock" => "株", "Future" => "先物", "Option" => "オプション", "Exchange" => "為替"}
    productDict[object.tradable_type]
  end

  def implimentation_date
    object.implimentation_date.strftime("%Y/%m/%d")
  end
end

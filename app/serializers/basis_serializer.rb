class BasisSerializer < ActiveModel::Serializer
  attributes :id, :trade_id, :basis_type, :text

  def basis_type
    if object.basis_type == BasisTypeEnum::TECHNICAL
      "テクニカル"
    elsif object.basis_type == BasisTypeEnum::FUNDAMENTALS
      "ファンダメンタルズ"
    elsif object.basis_type == BasisTypeEnum::ANOMALY
      "アノマリー"
    end
  end

end

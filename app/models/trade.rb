class Trade < ActiveRecord::Base
  belongs_to :tradable, polymorphic: true
  has_many :bases, dependent: :destroy
end

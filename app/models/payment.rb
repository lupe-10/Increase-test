class Payment < ApplicationRecord
    belongs_to :user
    has_many :transactions
    has_many :discounts

end

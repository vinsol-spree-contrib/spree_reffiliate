module Spree
  class CommissionRule < Spree::Base

    has_many :affiliate_commission_rules
    has_many :affiliate, through: :affiliate_commission_rules
    validates :name, presence: true
  end
end

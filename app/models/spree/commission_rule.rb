module Spree
  class CommissionRule < Spree::Base

    has_many :affiliate_commission_rules
    has_many :affiliate, through: :affiliate_commission_rules

    validates :name, presence: true

    def self.user_registration
      find_by(name: 'User Registration')
    end

    def self.order_placement
      find_by(name: 'Order Placement')
    end
  end
end

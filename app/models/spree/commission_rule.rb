module Spree
  class CommissionRule < Spree::Base
    USER_REGISTRATION = 'User Registration'
    ORDER_PLACEMENT = 'Order Placement'
    has_many :affiliate_commission_rules, dependent: :restrict_with_error

    validates :name, presence: true

    def self.user_registration
      find_by(name: USER_REGISTRATION)
    end

    def self.order_placement
      find_by(name: ORDER_PLACEMENT)
    end
  end
end

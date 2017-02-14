module Spree
  class AffiliateCommissionRule < Spree::Base
    has_many :transactions, class_name: 'Spree::CommissionTransaction', inverse_of: :affiliate_commission_rule
    belongs_to :affiliate, inverse_of: :affiliate_commission_rules
    belongs_to :commission_rule

    validates :affiliate, :commission_rule, presence: true
    validates :affiliate, uniqueness: { scope: :commission_rule_id, allow_blank: true }

    scope :active, -> { find_by(active: true) }
    scope :user_registration, -> { includes(:commission_rule).where(spree_commission_rules: { name: 'User Registration' }) }
    scope :order_placement, ->   { includes(:commission_rule).where(spree_commission_rules: { name: 'Order Placement' }) }
  end
end

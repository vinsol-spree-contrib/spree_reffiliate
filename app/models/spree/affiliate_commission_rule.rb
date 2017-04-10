module Spree
  class AffiliateCommissionRule < Spree::Base
    with_options required: true do
      belongs_to :affiliate, class_name: 'Spree::Affiliate', inverse_of: :affiliate_commission_rules
      belongs_to :commission_rule, class_name: 'Spree::CommissionRule'
    end

    validates :rate, presence: true
    validates :rate, numericality: { greater_than: 0, less_than_or_equal_to: 100, allow_nil: true }
    validates :affiliate_id, uniqueness: { scope: :commission_rule_id, allow_blank: true }

    before_create :assign_type_of_commission

    scope :active, -> { where(active: true) }
    scope :user_registration, -> { includes(:commission_rule).where(spree_commission_rules: { name: Spree::CommissionRule::USER_REGISTRATION }) }
    scope :order_placement, ->   { includes(:commission_rule).where(spree_commission_rules: { name: Spree::CommissionRule::ORDER_PLACEMENT }) }

    private
      def assign_type_of_commission
        self.fixed_commission = commission_rule.fixed_commission
        return true
      end
  end
end

module Spree::TransactionRegistrable
  extend ActiveSupport::Concern

  included do
    def register_commission_transaction(affiliate)
      if affiliate_commission_rule_present?(affiliate)
        self.transactions.create!(affiliate: affiliate, locked: false)
      end
    end

    def affiliate_commission_rule_present?(affiliate)
      if self.class.eql? Spree::User
        commission_rule_id = Spree::CommissionRule.user_registration.try(:id)
      elsif self.class.eql? Spree::Order
        commission_rule_id = Spree::CommissionRule.order_placement.try(:id)
      end
      affiliate.affiliate_commission_rules.active.where(commission_rule_id: commission_rule_id).present?
    end
  end
end

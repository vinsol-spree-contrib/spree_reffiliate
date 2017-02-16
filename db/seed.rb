Spree::CommissionRule.find_or_create_by(name: Spree::CommissionRule::USER_REGISTRATION).update_attributes(fixed_commission: true)
Spree::CommissionRule.find_or_create_by(name: Spree::CommissionRule::ORDER_PLACEMENT).update_attributes(fixed_commission: false)

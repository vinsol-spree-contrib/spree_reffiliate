Spree::CommissionRule.find_or_create_by(name: 'User Registration').update_attributes(fixed_commission: true)
Spree::CommissionRule.find_or_create_by(name: 'Order Placement').update_attributes(fixed_commission: false)

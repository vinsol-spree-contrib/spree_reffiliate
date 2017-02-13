module Spree
  class AffiliateCommisionRule < Spree::Base
    belongs_to :affiliate, inverse_of: :affiliate_commission_rules
    belongs_to :commission_rule

    validates :affiliate, :commission_rule, presence: true
    validates :affiliate, uniqueness: { scope: :commission_rule_id, allow_blank: true }
  end
end

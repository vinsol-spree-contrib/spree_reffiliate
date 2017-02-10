module Spree
  class AffiliateMailer < BaseMailer
    def activation_instruction
      @affiliate  = Spree::Affiliate.find_by(email: email)
    end
  end
end

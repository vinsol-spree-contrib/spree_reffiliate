module Spree
  class AffiliateMailer < BaseMailer
    def activation_instruction(email)
      @affiliate  = Spree::Affiliate.find_by(email: email)
      subject = (Spree.t(:affiliate_mailer_subject))
      mail(to: @affiliate.email, from: from_address, subject: subject)
    end
  end
end

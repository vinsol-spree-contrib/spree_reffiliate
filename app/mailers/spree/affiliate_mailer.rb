module Spree
  class AffiliateMailer < BaseMailer
    def activation_instruction(email)
      @affiliate  = Spree::Affiliate.find_by(email: email)
      subject = Spree.t(:activation_instruction_subject, scope: :affiliate_mailer)
      mail(to: @affiliate.email, from: from_address, subject: subject)
    end
  end
end

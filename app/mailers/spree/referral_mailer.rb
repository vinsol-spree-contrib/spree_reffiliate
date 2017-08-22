module Spree
  class ReferralMailer < BaseMailer
    def credits_awarded(referrer, amount)
      @amount = amount
      @referrer = referrer
      subject = Spree.t(:subject, scope: :referral_mail)
      mail(to: @referrer.email, from: from_address, subject: subject)
    end
  end
end

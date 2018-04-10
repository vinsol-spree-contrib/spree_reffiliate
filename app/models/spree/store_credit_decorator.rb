Spree::StoreCredit.class_eval do
  Spree::StoreCredit::REFERRAL_STORE_CREDIT_CATEGORY = 'Referral Credit'

  has_one :referred_record

  after_commit :send_credit_reward_information, on: :create, if: :referral?

  private
    def referral?
      category.try(:name) == Spree::StoreCredit::REFERRAL_STORE_CREDIT_CATEGORY
    end

    def send_credit_reward_information
      Spree::ReferralMailer.credits_awarded(user, amount.to_f).deliver_later
    end
end

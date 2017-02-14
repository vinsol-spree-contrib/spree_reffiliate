Spree::Order.class_eval do
  include Spree::TransactionRegistrable
  has_many :transactions, as: :commissionable, class_name: 'Spree::CommissionTransaction'

  state_machine.after_transition to: :complete, do: :create_commission_transaction

  private
    def create_commission_transaction
      affiliate = user.referred_record.try(:affiliate)
      register_commission_transaction(affiliate) if affiliate
    end
end

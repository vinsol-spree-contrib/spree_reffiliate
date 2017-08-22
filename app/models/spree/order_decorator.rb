Spree::Order.class_eval do
  include Spree::TransactionRegistrable

  has_many :transactions, as: :commissionable, class_name: 'Spree::CommissionTransaction', dependent: :restrict_with_error
  belongs_to :affiliate, class_name: 'Spree::Affiliate'

  state_machine.after_transition to: :complete, do: :create_commission_transaction

  private
    def create_commission_transaction
      register_commission_transaction(affiliate) if affiliate.present?
    end
end

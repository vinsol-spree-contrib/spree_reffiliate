module Spree
  class Commission < Spree::Base
    has_many :transactions, class_name: 'Spree::CommissionTransaction'
    belongs_to :affiliate, class_name: 'Spree::Affiliate'

    validates :start_date, :end_date, presence: true
    validate :cannot_mark_unpaid, if: [:paid?, :paid_changed?]

    self.whitelisted_ransackable_associations = %w[affiliate]
    self.whitelisted_ransackable_attributes =  %w[start_date end_date]

    define_model_callbacks :mark_paid, only: :after

    after_mark_paid :lock_transactions

    def mark_paid!
      run_callbacks :mark_paid do
        update_attributes!(paid: true)
      end
    end

    private
      def lock_transactions
        transactions.update_all!(locked: true)
      end

      def cannot_mark_unpaid
        errors.add(:base. Spree.t(:cannot_mark_unpaid))
      end
  end
end

module Spree
  class Commission < Spree::Base
    has_many :transactions, class_name: 'Spree::CommissionTransaction'
    belongs_to :affiliate, class_name: 'Spree::Affilate'

    validates :start_date, :end_date, presence: true

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
  end
end

module Spree
  class CommissionTransaction < Spree::Base
    belongs_to :affiliate, class_name: 'Spree::Affiliate', required: true
    belongs_to :commission, class_name: 'Spree::Commission', required: true, counter_cache: :transactions_count
    belongs_to :commissionable, polymorphic: true, required: true

    validate :cannot_change_commisson, :check_not_locked

    before_validation :assign_commission, :evaluate_amount, on: :create

    self.whitelisted_ransackable_attributes =  %w[amount created_at commission_id]

    def display_total
      currency = Spree::Config[:currency]
      Spree::Money.new(amount, { currency: currency })
    end

    private
      def assign_commission
        start_date = (created_at || Date.current).beginning_of_month.beginning_of_day
        end_date = start_date.end_of_month.beginning_of_day
        self.commission = Spree::Commission.find_or_create_by(start_date: start_date, end_date: end_date, affiliate_id: affiliate.id)
      end

      def cannot_change_commisson
        errors.add(:base, Spree.t(:cannot_change_commisson, scope: :commission_transaction)) if persisted? && commission_id.changed?
      end

      def evaluate_amount
        self.amount = Spree::TransactionService.new(self).calculate_commission_amount
        return true
      end

      def check_not_locked
        errors.add(:base, Spree.t(:locked_transaction, :commission_transaction)) if locked?
      end
  end
end

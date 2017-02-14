module Spree
  class CommissionTransaction < Spree::Base
    belongs_to :affiliate, class_name: 'Spree::Affiliate'
    belongs_to :commission, class_name: 'Spree::Commission'
    belongs_to :commissionable, polymorphic: true

    validates :locked, acceptance: { accept: 0, message: 'is locked' }
    validates :commission, presence: true
    validate :cannot_change_commisson, :not_locked

    before_validation :assign_commission, :evaluate_amount, on: :create

    private
      def assign_commission
        start_date = (self.created_at || Date.current).beginning_of_month
        end_date = start_date.end_of_month
        self.commission = Spree::Commission.find_or_create_by(start_date: start_date, end_date: end_date, affiliate_id: affiliate.id)
      end

      def cannot_change_commisson
        errors.add(:base, Spree.t(:cannot_change_commisson)) if persisted? && commission_id.changed?
      end

      def evaluate_amount
        self.amount = Spree::TransactionService.new(self).calculate_commission_amount
      end

      def not_locked
        errors.add(:base, Spree.t(:locked_transaction)) if locked?
      end
  end
end

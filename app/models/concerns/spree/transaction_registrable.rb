module Spree::TransactionRegistrable
  extend ActiveSupport::Concern
    included do
      def register_commission_transaction(affiliate)
        self.transactions.create!(affiliate: affiliate, locked: false)
      end
    end
end

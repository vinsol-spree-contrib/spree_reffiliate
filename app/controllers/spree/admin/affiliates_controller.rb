module Spree
  module Admin
    class AffiliatesController < ResourceController
      helper_method :affiliate_partial_exists?
      before_action :layout_options, only: [:new, :create, :edit, :update]
      before_action :build_or_load_affiliate_commission_rule, only: [:new, :edit]

      def index
        @affiliates = Affiliate.all.page(params[:page]).per(params[:per_page] || Spree::Config[:admin_affiliates_per_page])
      end

      def transactions
        params[:q] = {} unless params[:q]
        @commission_transactions = @affiliate.transactions
        @search = @commission_transactions.ransack(params[:q])
        @commission_transactions = @search.result.page(params[:page]).per(params[:per_page] || Spree::Config[:admin_transactions_per_page])
      end

      protected

      def affiliate_partial_exists? partial
        return false if partial.blank?
        Affiliate.lookup_for_partial lookup_context, partial
      end

      def layout_options
        @layout_options = Spree::Affiliate.layout_options
      end

      private

      def build_or_load_affiliate_commission_rule
        Spree::CommissionRule.all.map { |comm_rule| @affiliate.affiliate_commission_rules.find_or_initialize_by(commission_rule_id: comm_rule.id) }
      end
    end
  end
end

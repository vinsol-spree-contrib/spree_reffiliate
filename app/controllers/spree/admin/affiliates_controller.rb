module Spree
  module Admin
    class AffiliatesController < Spree::Admin::ResourceController
      helper_method :affiliate_partial_exists?
      before_action :layout_options, only: [:new, :edit, :update]
      before_action :build_or_load_affiliate_commission_rule, only: [:new, :edit]

      def index
        @affiliates = Affiliate.all.page(params[:page]).per(Spree::Config[:admin_products_per_page])
      end

      def transactions
        @commission_transactions = @affiliate.transactions.page(params[:page]).per(params[:per_page])
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

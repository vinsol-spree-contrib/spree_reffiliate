module Spree
  module Admin
    class CommissionsController < Spree::Admin::ResourceController
      belongs_to 'spree/affiliate'

      def index
        @commissions = @collection
      end

      def pay
        if @commission.mark_paid!
          redirect_to :index, success: Spree.t(:marke_paid_successfully)
        else
          redir :index, error: Spree.t(:marke_paid_failure)
        end
      end

      def transactions
        @transactions = @commission.transactions
      end


      private
        def collection
          return @collection if defined?(@collection)
          params[:q] = {} if params[:q].blank?

          @collection = super
          @search = @collection.ransack(params[:q])
          @collection = @search.result.includes(:affiliate).page(params[:page]).per(params[:per_page])
        end

    end
  end
end

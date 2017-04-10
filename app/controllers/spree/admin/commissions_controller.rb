module Spree
  module Admin
    class CommissionsController < ResourceController
      belongs_to 'spree/affiliate'

      def pay
        if @commission.mark_paid!
          flash[:success] = Spree.t(:mark_paid_successfully, scope: :commission)
        else
          flash[:error] = Spree.t(:mark_paid_failure, scope: :commission)
        end
        redirect_to admin_affiliate_commissions_path(@affiliate)
      end

      private
        def collection
          return @collection if defined?(@collection)
          params[:q] = {} if params[:q].blank?

          @collection = super
          @search = @collection.ransack(params[:q])
          @collection = @search.result.includes(:affiliate, :transactions).page(params[:page]).per(params[:per_page] || Spree::Config[:admin_commissions_per_page])
        end

    end
  end
end

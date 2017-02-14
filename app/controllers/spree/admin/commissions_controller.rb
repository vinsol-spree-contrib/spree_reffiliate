module Spree
  module Admin
    class CommissionsController < Spree::Admin::ResourceController
      belongs_to 'spree/affiliate'

      def index
        @commissions = @affiliate.commissions.page(params[:page]).per(params[:per_page])
      end

      def show
      end

    end
  end
end

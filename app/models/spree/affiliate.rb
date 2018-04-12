module Spree
  class Affiliate < Spree::Base

    attr_accessor :user, :active_on_create

    has_many :referred_records
    has_many :transactions, class_name: 'Spree::CommissionTransaction', dependent: :restrict_with_error
    has_many :commissions, class_name: 'Spree::Commission', dependent: :restrict_with_error
    has_many :affiliate_commission_rules, class_name: 'Spree::AffiliateCommissionRule', inverse_of: :affiliate, dependent: :destroy
    has_many :commission_rules, through: :affiliate_commission_rules, class_name: 'Spree::CommissionRule'

    accepts_nested_attributes_for :affiliate_commission_rules, reject_if: :invalid_rule

    validates :name, :path, :email, presence: true
    validates :email, :path, uniqueness: { allow_blank: true }
    validates :email, length: { maximum: 254, allow_blank: true }, email: { allow_blank: true }
    validates_associated :affiliate_commission_rules

    before_create :create_user, :process_activation
    after_commit :send_activation_instruction, on: :create

    self.whitelisted_ransackable_attributes =  %w[name email]

    def self.layout_options
      [
        ["No Layout", "false"],
        ["Spree Application Layout", 'spree/layouts/spree_application'],
        ["Custom Layout Path", nil]
      ]
    end

    def self.lookup_for_partial lookup_context, partial
      lookup_context.template_exists?(partial, ["spree/affiliates"], false)
    end

    def referred_users
      referred_records.includes(:user).collect(&:user).compact
    end

    def referred_orders
      order_ids = transactions.where(commissionable_type: 'Spree::Order').pluck(:commissionable_id)
      Spree::Order.where(id: order_ids)
    end

    def referred_count
      referred_records.count
    end

    def get_layout
      layout == 'false' ? false : layout
    end

    def referred_orders_count
      transactions.where(commissionable_type: 'Spree::Order').count
    end

    private

      def create_user
        @user = Spree::User.find_or_initialize_by(email: email)
        self.active_on_create = true if user.persisted?
        affiliate_role = Spree::Role.affiliate
        user.spree_roles << affiliate_role unless user.spree_roles.include?(affiliate_role)
        user.save!
      end

      def generate_activation_token
        self.activation_token = SecureRandom.hex(10)
      end

      def process_activation
        if active_on_create
          self.activation_token, self.active, self.activated_at = nil, true, Time.current
        else
          generate_activation_token
        end
      end

      def send_activation_instruction
        Spree::AffiliateMailer.activation_instruction(email).deliver_later
      end

      def invalid_rule(attributes)
        !attributes[:id] && !attributes[:rate].present? && !attributes[:active].eql?('1')
      end

  end
end

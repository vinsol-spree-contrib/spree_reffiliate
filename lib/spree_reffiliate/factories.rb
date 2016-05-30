FactoryGirl.define do
  factory :affiliate, class: Spree::Affiliate do
    name FFaker::Name.first_name
    path FFaker::Name.first_name
    partial FFaker::Name.first_name
    layout nil
  end

  factory :referral, class: Spree::Referral
  factory :referred_promotion_rule, class: Spree::Promotion::Rules::ReferredPromotionRule
  factory :affiliated_promotion_rule, class: Spree::Promotion::Rules::AffiliatedPromotionRule
end

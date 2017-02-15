Spree::Core::Engine.routes.draw do
  get 'r/:code' => 'reffiliate#referral', as: 'referral'
  get 'a/:path' => 'reffiliate#affiliate', as: 'affiliate'

  namespace :admin do
    resources :affiliates do
      resources :commissions do
        patch :pay, on: :member
      end
      get :transactions, on: :member
    end

    resources :commission_rules
  end

  namespace :affiliate do
    resources :confirmations, only: :new
  end
end

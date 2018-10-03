Spree Reffiliate
================

[![Codeship Status for kinduff/spree_reffiliate](https://codeship.com/projects/ab504f70-4b22-0132-8f9f-22e1dbe6882e/status)](https://codeship.com/projects/46636)
[![Build Status](https://travis-ci.org/kinduff/spree_reffiliate.svg?branch=master)](https://travis-ci.org/kinduff/spree_reffiliate)
[![Code Climate](https://codeclimate.com/github/kinduff/spree_reffiliate/badges/gpa.svg)](https://codeclimate.com/github/kinduff/spree_reffiliate)
[![Test Coverage](https://codeclimate.com/github/kinduff/spree_reffiliate/badges/coverage.svg)](https://codeclimate.com/github/kinduff/spree_reffiliate)

Spree Reffiliate is a [Spree] Extension that adds the referral and affiliate features to your Spree Store. Users are going to be able to share a unique hyperlink with their friends to gain benefits and you'll be able to create affiliate campaigns through the Spree Administrator and configure it to your needs.

Demo
-----------------------------------
Try Spree Reffiliate for Spree Master with direct deployment on Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/vinsol-spree-contrib/spree-demo-heroku/tree/spree-reffiliate-master)

Try Spree Reffiliate for Spree 3-4 with direct deployment on Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/vinsol-spree-contrib/spree-demo-heroku/tree/spree-refilliate)

Try Spree Reffiliate for Spree 3-1 with direct deployment on Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/vinsol-spree-contrib/spree-demo-heroku/tree/spree-reffiliate-3-1)

### Referrals
+ Each user will have a unique link associated to his account which he can use to refer other users.
+ User can signup as a referred user
+ Referred user can have promotions
+ Referrer can have store credits.

### Affiliates
+ Admin is able to create an affiliate with a custom path.
+ Customize the affiliate view with a partial
+ Affiliate can get commission in two ways:
  (i) Order placement
  (ii) User Registration
+ These commission amount can be defined from `affiliate_commission_rules` on affiliate new/edit page.
+ After successful user-creation/order-placement, a transaction will be created which will have the amount and commissionable(user/order).
+ Affilate can view it in account panel.
+ Affiliated user can have individual promotions
+ Admin is able to see affiliated users and orders from affiliate

![Spree Reffiliate](https://cloud.githubusercontent.com/assets/1270156/4210980/11c6ba84-387f-11e4-8f3d-4eb7f45f9004.png)

## Installation

To use the stable branch, add this line to your Gemfile:

```ruby
gem 'spree_reffiliate', github: 'vinsol-spree-contrib/spree_reffiliate'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_reffiliate:install
```
Seed the Commission Rules from `seed.rb`


### Existing Users
If you already have users within your database, you'll need to run the following command to generate the referral registry for your users:

```shell
bundle exec rake reffiliate:generate
```

## Usage

Referral path is `/r/:code` and Affiliate path (assigned in the admin) is `/a/:path`

Once installed, you'll be able to access the following methods.

#### Spree::User
+ referred_by => user record
+ referral_count => user count
+ referred? => boolean
+ affiliate? => boolean
+ affiliate => affiliate record
+ referral => referral record
+ associated_partner => user corrosponding to affiliate.

#### Spree::Referral
+ code => referral code
+ referred_users => array of users
+ referred_orders => array of orders
+ referred_count => user count
+ referral_activated_users => users with completed orders

#### Spree::Affiliate
+ referred_users => array of users
+ referred_orders => array of orders
+ referred_count => user count

## Affiliates

+ Affiliate listing can be found in affiliates subtab.
![Affiliate Registration](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/affliates-listing.png)

+ Admin can create a new affiliate.
![Affiliate Registration](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/affiliate-registration-new.png)

+ Affiliate will be send a email which will have an activation link.
![Affiliate Confirmation](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/affiliate-confirmation-crop.png)

![Affiliate Account Details](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/affiliate-account-details.png)

## Commissions

+ Admin can manage commission for an affiliate by default.
![Commission Listing](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/commission-listing-crop.png)

+ Admin can pay commission, once the commission cycle completes. The commission tab will have pay button which will mark respective commission as completes. This action, as a result, also locks corrosponding transactions.
![Commission Search](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/admin-pay-commission.png)

+ Commission search has advanced search filters.
![Commission Search](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/admin-commission-search.png)

## Transactions

+ Admin can list the transactions of affiliates.
![Transactions Listing](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/transactions-listing-crop.png)

## User account

+ User can see its affiliate link from my account.
![User account](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/affiliate-account-details.png)

+ Moreover, the user can check the transactions from account details page.
![User account](https://s3.amazonaws.com/gems-and-extensions-screenshots/refillate_images/my-account-transactions-crop.png)

## Referrals

+ Each user will have a unique link associated to his account which he can use to refer other users.
![Affiliate Account Details](https://s3.amazonaws.com/gems-and-extensions-screenshots/reffiliate_referral_images/user_myaccount.png)

+ User can signup as a referred user
+ Referred user can have promotions
+ Admin is able to see referred users and orders from user
+ Referrer gets store credit for successful referrals. A referral will be considered successful if referred user successfully signs up.
+ Admin can configure referral settings. There are two settings for giving referral benefits to referrer. One is the global setting found under configuration tab and other is user specific setting.
![Global Referral Setting](https://s3.amazonaws.com/gems-and-extensions-screenshots/reffiliate_referral_images/configuration_referrals_tab.png)

+ Global Settings : There are two global settings under Configuration->Referrals tabs with regard to referral. One is the store credit amount that would be credited to referer's account on each successful referral. Other is a checkbox to enable and disable the referral benefit to a referrer. By default store credit amount is set to 0 and referral benefit is disabled.
![Referral Settings Edit](https://s3.amazonaws.com/gems-and-extensions-screenshots/reffiliate_referral_images/referral_settings_edit_page.png)

+ User Specific Settings : Admin can override the referral settings for a particular user in user's general settings, where he may disable/enable the referral benefits and change the store credit amount. Default value for store credit is nil and referral benefit is enabled.
![User Specific Settings](https://s3.amazonaws.com/gems-and-extensions-screenshots/reffiliate_referral_images/user_referral_settings.png)

+ Referrer will receive store credit when referral is enabled at both global and user level. Store credit amount in user setting will have precedence over the global setting. In case the value is nil in user setting then global setting would apply for store credit amount.
+Referrer will receive mail on store credit transfer to his account
![Store Credit Mail](https://s3.amazonaws.com/gems-and-extensions-screenshots/reffiliate_referral_images/mail_to%20referrer.png)

+ Each user can see their referrals under My Account section. To see the details of referrals user can click on view more where all referred users will be listed with store credit amount and date of sign up by referred user.
![User Referral Details](https://s3.amazonaws.com/gems-and-extensions-screenshots/reffiliate_referral_images/myaccount_referral_details.png)

+ Admin can see store credits for a particular user under user's store credit section. The store credits received for referral will be listed under Referral Credit category.
![User Store Credits](https://s3.amazonaws.com/gems-and-extensions-screenshots/reffiliate_referral_images/admin_users_store_credits_list.png)

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

## See It In Action

<a href="http://www.youtube.com/watch?feature=player_embedded&v=CSis4gcj8Xg
" target="_blank"><img src="http://img.youtube.com/vi/CSis4gcj8Xg/0.jpg" 
alt="Youtube Video Tutorial" /></a>


## Credits

Copyright (c) 2014 Alejandro AR, released under the New BSD License

[Spree]: http://spreecommerce.com/

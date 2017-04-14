Deface::Override.new(
  virtual_path: "spree/admin/users/edit",
  name: "referral_fieldset",
  insert_after: "[data-hook='admin_user_api_key']"
) do
<<-CODE.chomp
<div data-hook="admin_user_referral_stats" class="panel panel-default">
  <div class="panel-heading">
    <h1 class="panel-title">
      <%= Spree.t(:referral_stats) %>
    </h1>
  </div>
  
  <table class="table" id="user-referral-stats" data-hook>
    <tr>
      <td width="30%"><%= Spree.t(:referred_by) %>:</td>
      <td>
        <% if @user.referred? %>
          <%= link_to(@user.referred_by.email, edit_admin_user_url(@user.referred_by)) %>
        <% elsif @user.affiliate? %>
          <%= link_to(@user.affiliate.name, edit_admin_affiliate_url(@user.affiliate)) %>
        <% else %>
          Organic
        <% end %>
      </td>
    </tr>
    <tr>
      <td><%= Spree.t(:referral_code) %>:</td>
      <td><%= @user.referral.code %></td>
    </tr>
    <tr>
      <td><%= Spree.t(:referred_orders) %>:</td>
      <td>
        <% if @user.referral.referred_orders.count.zero? %>
          <%= "No referred orders yet." %>
        <% else %>
          <ol>
            <% @user.referral.referred_orders.each do |order| %>
              <li><%= link_to order.number, edit_admin_order_path(order) %> (<%= order.state %>)</li>
            <% end %>
          <ol>
        <% end %>
      </td>
    </tr>
    <tr>
      <td><%= Spree.t(:users_referred) %>:</td>
      <td>
        <% if @user.referred_count.zero? %>
          <%= "No referred users yet." %>
        <% else %>
          <ol>
            <% @user.referral.referred_users.each do |user| %>
              <li><%= link_to user.email, edit_admin_user_url(user) %></li>
            <% end %>
          </ol>
        <% end %>
      </td>
    </tr>
  </table>
</div>
CODE
end

Deface::Override.new(
  virtual_path: "spree/admin/users/_form",
  name: "referral_settings",
  insert_after: "[data-hook='admin_user_form_password_fields']"
) do
<<-CODE.chomp
  <div data-hook="admin_user_form_referral_amount_field" class="col-md-6">
    <%= f.field_container :referral_credits, class: ['form-group'] do %>
      <%= f.label :referral_credits, Spree.t(:credits_to_be_awarded, scope: "user.referral_setting") %>
      <%= f.text_field :referral_credits, class: 'form-control' %>
      <%= f.error_message_on :referral_credits %>
    <% end %>

    <%= f.field_container :referrer_benefit_enabled, class: ['checkbox'] do %>
      <%= f.label :referrer_benefit_enabled do %>
        <%= f.check_box :referrer_benefit_enabled %>
         <%= Spree.t(:referral_credit_status, scope: "user.referral_setting") %>
      <% end %>
    <% end %>
  </div>
CODE
end

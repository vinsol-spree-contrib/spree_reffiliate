Deface::Override.new(
  virtual_path: "spree/users/show",
  name: "user_info",
  insert_after: "[data-hook='account_summary'] #user-info dd:first"
) do
<<-CODE.chomp
<br>
<dt>Referral URL</dt>
<dd class='col-md-6 row'>
  <div class="input-group">
    <input type='text' data-coupon-code=true value='<%= referral_url(@user.referral.code) %>' class='form-control' />
    <span class="input-group-btn">
      <button class="btn btn-primary" data-copy-coupon-code=true type="button" title='Copy to clipboard'><span class='glyphicon glyphicon-copy'></span></button>
    </span>
  </div>
</dd>
<br>
<br>
<br>
<div>
  <dt>Referred Users</dt>
  <dd><%= @user.referred_count%></dd>
</div>
CODE
end

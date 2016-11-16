var SpreeReffiliate = function(couponCode, copyCouponCode){
  this.couponCode = $(couponCode);
  this.copyCouponCode = $(copyCouponCode);
}

SpreeReffiliate.prototype.bindEvents = function() {
  var _this = this;
  this.copyCouponCode.on('click', function() {
    _this.couponCode.select()
    document.execCommand("copy")
  })
}

$(function(){
  var spreeReffiliate = new SpreeReffiliate("[data-coupon-code]", "[data-copy-coupon-code]")
  spreeReffiliate.bindEvents()
})

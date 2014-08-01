class TempOrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  # before_create :chek_order_detail
  #
  # private
  # def chek_order_detail
  #   old_order_detail = TempOrderDetail.find_by_order_id_and_product_summary_id_and_discount_percent(self.order_id, self.product_summary_id, self.discount_percent)
  #   if old_order_detail
  #     old_order_detail.quality += self.quality
  #     old_order_detail.total_amount = old_order_detail.quality * old_order_detail.price
  #     old_order_detail.discount_cash = (old_order_detail.discount_percent* old_order_detail.total_amount)/100
  #     old_order_detail.total_amount -= old_order_detail.discount_cash
  #     old_order_detail.save()
  #   end
  # end
end
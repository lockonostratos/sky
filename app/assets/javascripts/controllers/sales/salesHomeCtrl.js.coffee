Sky.salesHomeCtrl = ['$scope', '$routeParams','$http', 'Common', 'Product', 'ProductSummary', 'Customer', 'MerchantAccount', 'TempOrder', 'TempOrderDetail'
($scope, $routeParams, $http, Common, Product, ProductSummary, Customer, MerchantAccount, TempOrder, TempOrderDetail) ->


  $scope.transports = [
    {
      id: 0
      name: "Trực Tiếp"
    }
  ,
    {
      id: 1
      name: "Giao Hàng"
    }
  ]
  $scope.payment_methods = [
    {
      id: 0
      name: "Tiền Mặt"
    }
  ,
    {
      id: 1
      name: "Nợ"
    }
  ]
  $scope.tempOrder = {
    branch_id: 0
    warehouse_id: 0
    merchant_account_id: 0
    customer_id:0
    name: $scope.currentCustomer
    payment_method: 0
    delivery: 0
    bill_discount: false
    total_price: 0
    discount_voucher: 0
    discount_cash: 0
    final_price: 0
    deposit: 0
    currency_debit: 0 }

  $scope.currentCustomer = {}
  $scope.customers = []
  Customer.query().then (data) ->
    $scope.customers = data
    $scope.currentCustomer = data[0]
    $scope.tempOrder.customer_id =  $scope.currentCustomer.id

  $scope.currentAccount = {}
  $scope.sales_accounts = []
  MerchantAccount.get('current_sales').then (data) ->
    $scope.sales_accounts = data
    foundCurrent = $scope.sales_accounts.find({accountId: Common.currentMerchantAccount.accountId})
    $scope.currentAccount = if foundCurrent then foundCurrent else $scope.sales_accounts[0]
    #add tạm chổ này do ko biết chổ để hợp lý (lấy thông tin merchant_account_id, branch_id, warehouse_id)
    #khi load lần đầu chưa có order, sẽ tự tạo order
    $scope.tempOrder.merchant_account_id = $scope.currentAccount.accountId
    $scope.tempOrder.branch_id = Common.currentMerchantAccount.branchId
    $scope.tempOrder.warehouse_id = Common.currentMerchantAccount.currentWarehouseId

  $scope.productSummaryChange = ($item, $model, $label) ->
    $scope.tempOrderDetail = {}
    $scope.currentProduct = angular.copy $item
    #add dữ liệu ban đầu cho tempOrderDetail
    $scope.tempOrderDetail.order_id = $scope.tempOrder.id
    $scope.tempOrderDetail.product_summary_id = $scope.currentProduct.id
    $scope.tempOrderDetail.product_code = $scope.currentProduct.productCode
    $scope.tempOrderDetail.skull_id = $scope.currentProduct.skullId
    $scope.tempOrderDetail.warehouse_id = $scope.currentProduct.warehouseId
    $scope.tempOrderDetail.price = $scope.currentProduct.price
    $scope.tempOrderDetail.quality = 1
    if calculation_max_sale_product($scope.tempOrderDetail) <=0
      $scope.tempOrderDetail.quality = 0
    $scope.tempOrderDetail.discount_cash = 0
    $scope.tempOrderDetail.discount_percent = 0
    $scope.tempOrderDetail.total_price = $scope.currentProduct.price * $scope.tempOrderDetail.quality
    $scope.tempOrderDetail.total_amount = $scope.currentProduct.price * $scope.tempOrderDetail.quality


  $scope.createTempOrder = ()->
    tempOrder = Sky.gs('TempOrder')
    tempOrder.$post('api/temp_orders', $scope.tempOrder)

  $scope.tempOrderDetailTabs = []
  TempOrderDetail.query().then (data) -> $scope.tempOrderDetailTabs = data

  #Khởi tạo tab của order
  $scope.tempOrderTabs = []
  TempOrder.query().then (data) ->
    $scope.tempOrderTabs = data
    if $scope.tempOrderTabs[0] == undefined
      tempOrder = Sky.gs('TempOrder')
      tempOrder.$post('api/temp_orders', $scope.tempOrder)
      TempOrder.query().then (data) ->
        $scope.tempOrderTabs = data
    else
      $scope.tempOrderTabs = data

  $scope.product_summaries = []
  ProductSummary.query().then (data) ->
    for item in data
      item.fullSearch = item.name
      item.fullSearch += ' (' + item.skullId + ')' if item.skullId
      $scope.product_summaries.push item


  $scope.addNewTab =() ->
    tempOrder = Sky.gs('TempOrder')
    tempOrder.$post('api/temp_orders', $scope.tempOrder)
    TempOrder.query().then (data) ->
      $scope.tempOrderTabs = data
      a = index for item, index in $scope.tempOrderTabs
      $scope.tempOrderTabs[a].active = true

  $scope.removeTab =() ->
    for item, index in $scope.tempOrderTabs
      if item.id == $scope.tempOrder.id
        item.delete()
        for item_detail in $scope.tempOrderDetails
          item_detail.delete()
          for item_detail_tab, i in $scope.tempOrderDetailTabs
            if item_detail_tab.id == item_detail.id
              $scope.tempOrderDetailTabs.splice index, 1
        $scope.tempOrderTabs.splice index, 1



    if $scope.tempOrderTabs[0] == undefined
      tempOrder = Sky.gs('TempOrder')
      tempOrder.$post('api/temp_orders', $scope.tempOrder)
      TempOrder.query().then (data) ->
        $scope.tempOrderTabs = data


  #chuyển đổi dữ liệu qua tab
  $scope.select_order = (item)->
    $scope.currentProduct = undefined
    $scope.tempOrderDetail = undefined
    $scope.tempOrder = item
    $scope.tempOrderDetails = []
    for item in $scope.tempOrderDetailTabs when item.orderId == $scope.tempOrder.id then $scope.tempOrderDetails.push item
    rechange_temp_order_detail($scope.tempOrder.billDiscount)




  #Add GirdView-------------------------
  $scope.addProductSummary = (item) -> calculation_addProductSummary(item)
  #cập nhật khi thay đổi người mua và người bán
  $scope.change_currentAccount = (item)-> $scope.tempOrder.merchantAccountId = item.accountId
  $scope.change_currentCustomer = (item)-> $scope.tempOrder.customerId = item.id
  $scope.change_current_payment_method = (item)-> $scope.tempOrder.paymentMethod = item.id
  $scope.change_current_delivery = (item)-> $scope.tempOrder.delivery = item.id

  #cập nhật giá tiền khi thay đổi số lượng mua, giảm giá Từng Sản Phẩm
  $scope.change_tempOrderDetail_quality = (item)-> calculation_tempOrderDetail(item, true)
  $scope.change_tempOrderDetail_discount_cash = (item)-> calculation_tempOrderDetail(item, true)
  $scope.change_tempOrderDetail_discount_percent = (item)-> calculation_tempOrderDetail(item, false)
  #cập nhật giá tiền khi thay đổi số lượng mua, giảm giá Tổng Bill
  $scope.change_tempOrder_discount_percent = (item)-> calculation_tempOrder(item, false)
  $scope.change_tempOrder_discount_cash = (item)-> calculation_tempOrder(item, true)

  $scope.change_bill_discount =() ->
    disabled = true
    if $scope.tempOrder.billDiscount == true then disabled = true  else disabled = false
    if $scope.tempOrderDetails[0] == undefined then disabled = true
    return disabled


  $scope.change_cheked_bill =(item) -> rechange_temp_order_detail(item)

  rechange_temp_order_detail = (item,boolean) ->
    if item
      $scope.tempOrder.discountVoucher = $scope.tempOrder.discountCash = $scope.tempOrder.discountPercent = 0
      $scope.tempOrder.finalPrice = $scope.tempOrder.totalPrice
      for item in $scope.tempOrderDetails
        temp = item.discountCash
        item.tempDiscountCash = temp
        temp = item.discountPercent
        item.tempDiscountPercent = temp
        item.totalAmount = item.quality * item.price
        item.discountCash = 0
        item.discountPercent = 0
      $scope.tempOrder.update()
    else
      for item in $scope.tempOrderDetails
        temp = item.tempDiscountCash
        item.discountCash = temp
        temp = item.tempDiscountPercent
        item.discountPercent = temp
        item.totalAmount = item.totalAmount - item.discountCash
    if boolean then recalculation_tempOrder()

  $scope.removeProductSummary = (item, index, curr) ->
    item.delete()
    TempOrderDetail.query().then (data) ->
      $scope.tempOrderDetailTabs = data
      $scope.tempOrderDetails = []
      for item in $scope.tempOrderDetailTabs when item.orderId == $scope.tempOrder.id then $scope.tempOrderDetails.push item
      recalculation_tempOrder()
    if $scope.tempOrderDetails[0] == undefined then $scope.tempOrder.billDiscount = false



  $scope.finishProductSummary = (item) ->
    a = Sky.gs('Order')
    a.$post('api/orders',item)

  $scope.change_tempOrder_discountVoucher = (item) ->
    $scope.tempOrder.discountVoucher = calculation_item_range_min_max(item, 0, ($scope.tempOrder.totalPrice - $scope.tempOrder.discountCash))
    $scope.tempOrder.finalPrice = ($scope.tempOrder.totalPrice - $scope.tempOrder.discountCash) - $scope.tempOrder.discountVoucher

#add sản phẩm vào girdview---------------------------------------------------------------------------------->

  #Add sản phẩm vào GirdView
  calculation_addProductSummary = (item)->
    if $scope.tempOrder.billDiscount == true
      item.discount_percent = 0
      item.discount_cash = 0
      item.total_amount = item.quality * item.price
    if $scope.tempOrderDetail.quality != 0
      $scope.a = true
      for product, index in $scope.tempOrderDetails
        if (product.productSummaryId == item.product_summary_id and product.discountPercent == item.discount_percent)
          update_product(product, item, index)
          if $scope.tempOrderDetail.quality > calculation_max_sale_product() then $scope.tempOrderDetail.quality = calculation_max_sale_product()
      if $scope.a
        tempOrderDetail = Sky.gs('TempOrderDetail')
        tempOrderDetail.$post('api/temp_order_details', item)
        TempOrderDetail.query().then (data) ->
          $scope.tempOrderDetailTabs = data
          $scope.tempOrderDetails = []
          for item in $scope.tempOrderDetailTabs when item.orderId == $scope.tempOrder.id then $scope.tempOrderDetails.push item
          recalculation_tempOrder()
          if $scope.tempOrderDetail.quality > calculation_max_sale_product() then $scope.tempOrderDetail.quality = calculation_max_sale_product()



  update_product = (product, item, index)->
    product.quality += item.quality
    product.discountCash = (product.discountPercent*(product.quality * product.price))/100
    product.totalAmount = (product.quality * product.price) - product.discountCash
    product.update()
    recalculation_tempOrder()
    $scope.a = false

  recalculation_tempOrder = ()->
    $scope.tempOrder.totalPrice = 0
    $scope.tempOrder.finalPrice = 0
    $scope.tempOrder.discountCash = 0
    update_tempOrder($scope.tempOrder, product) for product, index in $scope.tempOrderDetails
    if $scope.tempOrder.discountCash == 0 then $scope.tempOrder.discountPercent = 0 else $scope.tempOrder.discountPercent = ($scope.tempOrder.discountCash * 100)/$scope.tempOrder.totalPrice
    $scope.tempOrder.finalPrice = $scope.tempOrder.finalPrice - $scope.tempOrder.discountVoucher
    $scope.tempOrder.update()

  update_tempOrder = (item, product)->
    if $scope.tempOrder.billDiscount == true
      item.totalPrice += (product.price * product.quality)
      item.finalPrice += (product.price * product.quality)
    else
      item.totalPrice += (product.price * product.quality)
      item.finalPrice += product.totalAmount
      item.discountCash += product.discountCash


  calculation_tempOrderDetail = (item, boolean)->
    item.quality = calculation_item_range_min_max(item.quality, 0, calculation_max_sale_product())
    item.total_price =  item.quality * item.price
    item.discount_cash = calculation_item_range_min_max(item.discount_cash, 0, item.total_price)
    item.discount_percent = calculation_item_range_min_max(item.discount_percent, 0, 100)
    if item.quality > 0
      if boolean
        item.discount_percent = (item.discount_cash/item.total_price)*100
      else
        item.discount_cash = (item.discount_percent*item.total_price)/100
    else
      item.discount_percent = 0
      item.discount_cash = 0
    item.total_amount = item.total_price - item.discount_cash


  calculation_item_range_min_max = (item, min, max)->
    if item == undefined || item == 0 || item == null then item = min
    if item > max then item = max
    return  item

  calculation_max_sale_product = ->
    temp = 0
    a=0
    for product in $scope.tempOrderDetailTabs
      if product.productSummaryId == $scope.currentProduct.id then temp += product.quality
    a = $scope.currentProduct.quality - temp
    return a


  calculation_tempOrder = (item, boolean)->
    item.discountCash = calculation_item_range_min_max(item.discountCash, 0, item.totalPrice)
    item.discountPercent = calculation_item_range_min_max(item.discountPercent, 0, 100)
    if boolean
      item.discountPercent = (item.discountCash/item.totalPrice)*100
    else
      item.discountCash = (item.discountPercent*item.totalPrice)/100
    item.finalPrice = item.totalPrice - item.discountCash
]
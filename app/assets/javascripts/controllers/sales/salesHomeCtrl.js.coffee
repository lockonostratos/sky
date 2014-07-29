Sky.salesHomeCtrl = ['$scope', '$routeParams','$http', 'Common', 'Product', 'ProductSummary', 'Customer', 'MerchantAccount', 'TempOrder'
($scope, $routeParams, $http, Common, Product, ProductSummary, Customer, MerchantAccount, TempOrder) ->

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
    foundCurrent = Lazy($scope.sales_accounts).findWhere({accountId: Common.currentMerchantAccount.accountId})
    $scope.currentAccount = if foundCurrent then foundCurrent else $scope.sales_accounts[0]
    #add tạm chổ này do ko biết chổ để hợp lý (lấy thông tin merchant_account_id, branch_id, warehouse_id)
    $scope.tempOrder.merchant_account_id = $scope.currentAccount.accountId
    $scope.tempOrder.branch_id = Common.currentMerchantAccount.branchId
    $scope.tempOrder.warehouse_id = Common.currentMerchantAccount.currentWarehouseId


  $scope.productSummaryChange = ($item, $model, $label) ->
    $scope.currentProduct = $item
    #add dữ liệu ban đầu cho tempOrderDetail
    $scope.tempOrderDetail.order_id = $scope.tempOrder.id
    $scope.tempOrderDetail.product_id = $scope.currentProduct.id
    $scope.tempOrderDetail.price = $scope.currentProduct.price
    $scope.tempOrderDetail.quality = 1
    $scope.tempOrderDetail.discount_cash = 0
    $scope.tempOrderDetail.discount_percent = 0
    $scope.tempOrderDetail.total_price = $scope.currentProduct.price
    $scope.tempOrderDetail.final_price = $scope.currentProduct.price
    $scope.tempOrderDetail.total_amount = $scope.currentProduct.price

  $scope.createTempOrder = ()->
    tempOrder = Sky.gs('TempOrder')
    tempOrder.$post('api/temp_orders', $scope.tempOrder)
  TempOrder.query().then (data) ->
    $scope.tempOrder = data[0]

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
  $scope.product_summaries = []
  ProductSummary.query().then (data) ->
    for item in data
      item.fullSearch = item.name
      item.fullSearch += ' (' + item.skullId + ')' if item.skullId
      $scope.product_summaries.push item

  #Tạo phiếu order tạm
  $scope.tempOrder = {
    branch_id: 0
    warehouse_id: 0
    merchant_account_id: 0
    customer_id:0
    payment_method: 0
    delivery: 0
    bill_discount: false
    total_price: 0
    discount_voucher: 0
    discount_cash: 0
    final_price: 0
    deposit: 0
    currency_debit: 0 }
  $scope.tempOrderDetail = {}



  $scope.productList = {
    enable_input: true
    enable_input_bill: true
    enable_input_voucher: true
    bill_code:''
    bill_print_show: ''
    delivery_code: ''
    buy_product_list: []
    order_summary: {
      temp:0
      merchant_account:0
      merchant_customer:0
      warehouse_id:1
      name:'Sang'

      payment_method:0 #phương thức thanh toán(0 là tiền mặt, 1 nợ)
      delivery:0 #phương thức vận chuyển (0 là mua trực tiếp, 1 là giao hàng)
      status:0

      money:0 #tiền nhận vào
      money1:0 #tiền thối lại
      voucher: 0 #giảm tiền theo voucher
      bill_discount:false #giảm giá bill (false theo từng sản phẩm, true theo tổng bill)
      discount_cash:0
      discount_percent_bill:0
      deposit:0

      temp_final_price:0
      total_price: 0 #tổng tiền bill chưa trừ giảm giá
      final_price:0 #tổng tiền bill trừ giảm giá
    }
  }
  #cập nhật khi thay đổi người mua và người bán
  $scope.change_currentAccount = (item)-> $scope.tempOrder.merchant_account_id = item.accountId
  $scope.change_currentCustomer = (item)-> $scope.tempOrder.customer_id = item.id
  $scope.change_current_payment_method = (item)-> $scope.tempOrder.payment_method = item.id
  $scope.change_current_delivery = (item)-> $scope.tempOrder.delivery = item.id
  $scope.disable_voucher = ->
    if $scope.productList.enable_input_bill == false and $scope.productList.order_summary.bill_discount == false
      $scope.productList.enable_input_voucher == false
    else
      $scope.productList.enable_input_voucher == true

  #cập nhật giá tiền khi thay đổi số lượng mua, giảm giá
  $scope.change_tempOrderDetail_quality = (item)-> calculation_tempOrderDetail(item, true)


  #tạo dữ liệu và cập nhật hàng hóa vào bảng
  $scope.addProductSummary = (item, val) -> calculation_addProductSummary(item, val)
  $scope.removeProductSummary = (item, index) -> calculation_removeProductSummary(item, index)
  $scope.finishProductSummary = (item) -> calculation_finishProductSummary(item)

  #cập nhật giảm voucher, giảm giá tổng bill
  $scope.change_order_summary_voucher = (item) -> calculation_change_order_summary_voucher(item)
  $scope.change_order_summary_money = (item) -> calculation_change_order_summary_money(item)
  $scope.change_order_summary_bill_discount_percent = (item) -> calculation_change_order_summary_bill_discount_percent(item)
  $scope.change_order_summary_bill_discount_cash = (item) -> calculation_change_order_summary_bill_discount_cash(item)



  #cập nhật số tiền khi số lượng mua thay đổi-------------------------------------------------------------------------->
  calculation_tempOrderDetail = (item, boolean)->
    $scope.tempOrderDetail.quality = calculation_item_min_max(item.quality, 1, 50)
    $scope.tempOrderDetail.discount_cash = calculation_item_min_max(item.discount_cash, 0, 50)
    $scope.tempOrderDetail.discount_percent = calculation_item_min_max(item.discount_percent, 1, 100)

    $scope.tempOrderDetail.discount_cash = 0
    $scope.tempOrderDetail.discount_percent = 0
    $scope.tempOrderDetail.total_price = $scope.currentProduct.price
    $scope.tempOrderDetail.final_price = $scope.currentProduct.price
    $scope.tempOrderDetail.total_amount = $scope.currentProduct.price

    item.total_price =  item.sale_quality * item.price
    item.final_price = item.sale_quality * item.price - item.discount_cash
    item.discount_percent = (item.discount_cash/item.total_price)*100



  calculation_item_min_max = (item, min, max)->
    if item == undefined || item == 0 || item == null then item = min
    if item > max then item = max
    return  item


  #add sản phẩm vào girdview------------------------------------------------------------------------------------------->
  calculation_addProductSummary = (item, val)->
    new_item = angular.copy item
    new_item.product_code = new_item.productCode
    new_item.skull_id = new_item.skullId
    new_item.warehouse_id = new_item.warehouseId
    new_item.merchant_account_id = new_item.merchantAccountId
    a = true;
    if $scope.product_summaries.indexOf($scope.current_product_summary) != -1 and new_item.sale_quality > 0 and val == true
      $scope.current_product_summary = $scope.product_summaries[-1]
      $scope.productList.enable_input = true
    for product, index in $scope.productList.buy_product_list
      if product.id == new_item.id and product.discount_percent == new_item.discount_percent
        product.sale_quality += new_item.sale_quality
        product.discount_cash += new_item.discount_cash
        product.total_price = product.sale_quality * product.price
        product.final_price = product.total_price - product.discount_cash
        a=false;
        break
    if a == true
      $scope.productList.buy_product_list.push new_item
    $scope.productList.order_summary.total_price += new_item.total_price
    $scope.productList.order_summary.final_price += new_item.final_price
    $scope.productList.order_summary.temp_final_price += new_item.final_price
    $scope.productList.enable_input_bill = false
    # hiện số sản phẩm còn bán được trong kho
    $scope.productList.order_summary.temp = 0
    for items, index in $scope.productList.buy_product_list when items.id == item.id then $scope.productList.order_summary.temp += items.sale_quality
    if $scope.productList.order_summary.temp == item.quality
      $scope.productList.enable_input = true
      item.sale_quality = 0
      item.discount_cash = 0
      item.discount_percent = 0
      item.total_price = 0
      item.final_price = 0
    if item.sale_quality > (item.quality - $scope.productList.order_summary.temp)
      item.sale_quality = item.quality - $scope.productList.order_summary.temp
      item.discount_cash = 0
      item.discount_percent = 0
      item.total_price =  item.sale_quality * item.price
      item.final_price = item.sale_quality * item.price - item.discount_cash
    #cập nhật vào tổng bill
    calculation_change_buy_product_list($scope.productList.order_summary.bill_discount)

  # xóa sản phẩm khỏi girdview
  calculation_removeProductSummary = (item, index)->
    $scope.productList.buy_product_list.splice index, 1
    $scope.productList.order_summary.total_price -= item.total_price
    $scope.productList.order_summary.temp_final_price -= item.final_price
    if $scope.productList.order_summary.voucher > $scope.productList.order_summary.temp_final_price
      $scope.productList.order_summary.voucher = $scope.productList.order_summary.temp_final_price
    if $scope.productList.order_summary.money < ($scope.productList.order_summary.temp_final_price - $scope.productList.order_summary.voucher)
      $scope.productList.order_summary.money = ($scope.productList.order_summary.temp_final_price - $scope.productList.order_summary.voucher)
      $scope.productList.order_summary.money1 = 0
    else
      $scope.productList.order_summary.money1 = $scope.productList.order_summary.money - ($scope.productList.order_summary.temp_final_price - $scope.productList.order_summary.voucher)
    $scope.productList.order_summary.final_price = $scope.productList.order_summary.temp_final_price - $scope.productList.order_summary.voucher

    #disabled các button khi tiền = 0
    if $scope.productList.order_summary.total_price <=0 then $scope.productList.enable_input_bill = true
    if $scope.productList.order_summary.total_price <=0 then $scope.productList.order_summary.bill_discount = false
    calculation_change_product_summary($scope.current_product_summary)
    #cập nhật vào tổng bill
    calculation_change_buy_product_list($scope.productList.order_summary.bill_discount)



  #cập nhật số tiền khi giảm giá phần trăm thay đổi
  calculation_change_product_summary_discount_percent = (item)->
    if item.discount_percent == undefined || item.discount_percent <= 0  then item.discount_percent = 0
    if item.discount_percent >= 100 then item.discount_percent = 100
    item.total_price = item.sale_quality * item.price
    item.discount_cash = (item.discount_percent * item.price * item.sale_quality)/100
    item.final_price = item.sale_quality * item.price - item.discount_cash

  #cập nhật số tiền khi giảm giá tiền mặt thay đổi
  calculation_change_product_summary_discount_cash = (item)->
    if item.discount_cash == undefined || item.discount_cash <= 0
      item.discount_percent = 0
      item.discount_cash = 0
    item.total_price = item.sale_quality * item.price
    if item.discount_cash > item.total_price then item.discount_cash = item.total_price
    item.discount_percent = (item.discount_cash * 100)/item.total_price
    item.final_price = item.sale_quality * item.price - item.discount_cash

  #cập nhật số tiền tổng Bill khi giảm giá Vocher thay đổi------------------------------------------------------------->
  calculation_change_order_summary_voucher = (item)->
    if item >  $scope.productList.order_summary.temp_final_price
      $scope.productList.order_summary.voucher = $scope.productList.order_summary.temp_final_price
      item = $scope.productList.order_summary.temp_final_price
    if item <= 0 || item == undefined || item == null
      item = 0
      $scope.productList.order_summary.voucher  = 0
    $scope.productList.order_summary.final_price = $scope.productList.order_summary.temp_final_price - item
    if $scope.productList.order_summary.money < $scope.productList.order_summary.final_price
      $scope.productList.order_summary.money = $scope.productList.order_summary.final_price
    $scope.productList.order_summary.money1 = $scope.productList.order_summary.money - $scope.productList.order_summary.final_price

  #câp nhật tiền tổng bill theo tiền thu vào khách hàng
  calculation_change_order_summary_money = (item)->
    if item <= $scope.productList.order_summary.final_price
      $scope.productList.order_summary.money = $scope.productList.order_summary.final_price
      $scope.productList.order_summary.money1 = 0
    if item = 0 then  $scope.productList.order_summary.money1 = 0

  calculation_change_order_summary_bill_discount_percent = (item)->
    if item < 0 || item == undefined || item == null then $scope.productList.order_summary.discount_percent_bill = 0
    if item > 100 then  $scope.productList.order_summary.discount_percent_bill = 100
    $scope.productList.order_summary.discount_cash =  $scope.productList.order_summary.temp_final_price * $scope.productList.order_summary.discount_percent_bill / 100
    $scope.productList.order_summary.final_price = $scope.productList.order_summary.temp_final_price - $scope.productList.order_summary.discount_cash
    if $scope.productList.order_summary.money < $scope.productList.order_summary.final_price
      $scope.productList.order_summary.money = $scope.productList.order_summary.final_price
      $scope.productList.order_summary.money1 = 0
    else
      $scope.productList.order_summary.money1 = $scope.productList.order_summary.money - $scope.productList.order_summary.final_price

  calculation_change_order_summary_bill_discount_cash = (item)->
    if item < 0 || item == undefined || item == null then $scope.productList.order_summary.discount_cash = 0
    if item > $scope.productList.order_summary.temp_final_price then  $scope.productList.order_summary.discount_cash =  $scope.productList.order_summary.temp_final_price
    $scope.productList.order_summary.discount_percent_bill = $scope.productList.order_summary.discount_cash/($scope.productList.order_summary.temp_final_price/100)
    $scope.productList.order_summary.final_price = $scope.productList.order_summary.temp_final_price - $scope.productList.order_summary.discount_cash
    if $scope.productList.order_summary.money < $scope.productList.order_summary.final_price
      $scope.productList.order_summary.money = $scope.productList.order_summary.final_price
      $scope.productList.order_summary.money1 = 0
    else
      $scope.productList.order_summary.money1 = $scope.productList.order_summary.money - $scope.productList.order_summary.final_price



  #câp nhật lên server
  calculation_finishProductSummary = (item)->
    a = Sky.gs('Order')
    a.$post('api/orders',item)



  calculation_change_buy_product_list = (item)->
    if item == false
      $scope.productList.order_summary.discount_cash = 0
      $scope.productList.order_summary.discount_percent_bill = 0
      for product, index in $scope.productList.buy_product_list
        $scope.productList.order_summary.discount_cash += product.discount_cash
      if $scope.productList.order_summary.discount_cash == 0
        $scope.productList.order_summary.discount_percent_bill = 0
      else
        $scope.productList.order_summary.discount_percent_bill = 100/($scope.productList.order_summary.total_price/$scope.productList.order_summary.discount_cash)
      $scope.productList.order_summary.final_price = $scope.productList.order_summary.total_price - $scope.productList.order_summary.discount_cash
    calculation_change_order_summary_money($scope.productList.order_summary.money)

  $scope.$watch "productList.order_summary.bill_discount", ->
    $scope.productList.order_summary.discount_cash = 0
    $scope.productList.order_summary.discount_percent_bill = 0
    $scope.productList.order_summary.voucher = 0
    if $scope.productList.order_summary.bill_discount == false
      calculation_change_buy_product_list($scope.productList.order_summary.bill_discount)
    else
      $scope.productList.order_summary.final_price = $scope.productList.order_summary.total_price
]
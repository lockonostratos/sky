Sky.salesIndexCtrl = ['$scope', '$routeParams', 'Product', ($scope, $routeParams, Product) ->
  $scope.message = 'This is sale controller'
  $scope.warehouses = [
    id: 1
    name: 'HOCHIMINH'
  ,
    id: 2
    name: 'HANOI'
  ]
  $scope.currentWarehouse = $scope.warehouses[1].id

  $scope.product = new Product()
  Product.query().then (data) ->
    $scope.products = data

  $scope.addItem = (item) ->
    item.create()
    $scope.products.push angular.copy item
    $scope.product = new Product()

  $scope.removeItem = (item, index) ->
#    Product.delete(item)
    item.delete()
    $scope.products.splice index, 1

  $scope.updateItem = (item) ->
    item.name = $scope.product.name
    item.price = $scope.product.price
    item.update()
]
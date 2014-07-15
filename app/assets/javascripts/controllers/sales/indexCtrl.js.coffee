Sky.salesIndexCtrl = ['$scope', '$routeParams', '$http', 'Product', ($scope, $routeParams, $http, Product) ->
  $scope.message = 'This is sale controller'
  $scope.warehouses = [
    id: 1
    name: 'HOCHIMINH'
  ,
    id: 2
    name: 'HANOI'
  ]

  $scope.product = new Product()
  $scope.products = Product.query()

  $scope.currentWarehouse = $scope.warehouses[1].id
  $scope.addItem = (item) ->
    item.$save ->
      console.log item
    $scope.products.push angular.copy item
    $scope.product = new Product()

  $scope.removeItem = (item, index) ->
#    Product.delete(item)
    Product.delete item
    $scope.products.splice index, 1
  $scope.updateItem = (item) ->
    item.name = $scope.product.name
    item.price = $scope.product.price
    Product.update item
]
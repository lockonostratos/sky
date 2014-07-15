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
    $scope.product.$save()
    $scope.products.push item
    $scope.product = new Product()

  $scope.removeItem = (index)->
    $scope.buyList.splice index, 1

  $scope.addToCart = (item) ->
    $http.post('/products', item).success (data) ->
      $scope.buyList.push item
]
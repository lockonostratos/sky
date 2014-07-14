Sky.salesIndexCtrl = ['$scope', '$routeParams', ($scope, $routeParams) ->
  $scope.message = 'This is sale controller'
  $scope.warehouses = [
    id: 1
    name: 'HOCHIMINH'
  ,
    id: 2
    name: 'HANOI'
  ]
  $scope.currentWarehouse = $scope.warehouses[1].id
  $scope.buyList = []
  $scope.addItem = (item) ->
    $scope.buyList.push item
    $scope.product = {}

  $scope.removeItem = (index)->
    $scope.buyList.splice index, 1
]
Sky.importCtrl = ['$scope', '$routeParams', 'Common', 'TempImport', 'TempImportDetail'
($scope, $routeParams, Common, TempImport, TempImportDetail) ->
  Common.caption = 'nhập kho'
  $scope.message = 'message from import'

  $scope.currentImport = new TempImport()
  TempImport.query().then (data) -> $scope.currentImport = data if data

  $scope.currentDetails = []
  TempImportDetail.query().then (data) -> $scope.currentDetails = data

  $scope.saveImportHeaders = ->
    $scope.currentImport.update()
    console.log 'saving..'
]
Sky.controller 'applicationCtrl', ['$routeParams', '$location', '$scope', ($routeParams, $location, $scope) ->
  @showMenu = true;
  @collapsedMode = false;
  @name = 'Enterprise Dual Strategy'
  @currentUrl = $location.path()
  @navs = [
    active: true
    title: 'TỔNG QUAN'
    url: '/'
    icon: 'fa-desktop'
  ,
    title: 'BÁN HÀNG'
    url: '/sales'
    icon: 'fa-shopping-cart'
  ]

  @toggleCollapse = -> @collapsedMode = !@collapsedMode

  $scope.$on '$routeChangeSuccess', (e, current, previous) =>
    @currentUrl = current.originalPath
    console.log @currentUrl

  return
]
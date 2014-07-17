Sky.controller 'applicationCtrl', ['$routeParams', ($routeParams) ->
  @showMenu = true;
  @name = 'Enterprise Dual Strategy'
  @navs = [
    title: 'Home'
    url: '/'
  ,
    title: 'Sales'
    url: '/sales'
  ]

  return
]
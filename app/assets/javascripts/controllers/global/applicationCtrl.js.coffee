Sky.controller 'applicationCtrl', ['$routeParams', ($routeParams) ->
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
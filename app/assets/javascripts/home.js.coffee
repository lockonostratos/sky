#= require_self
#= require_tree ./controllers/home

window.Sky = angular.module 'Sky', ['ngRoute']

Sky.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when('/post/:postId',  {
    templateUrl: '../assets/home/mainPost.html'
    controller: 'postCtrl'
  })
  .otherwise({
    templateUrl: '../assets/home/index.html'
    controller: 'indexCtrl'
  })
]
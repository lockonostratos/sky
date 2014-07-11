#= require_self
#= require_tree ./controllers/home

Sky = angular.module 'Sky', []
Sky.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when('/post/:postId',  {
    templateUrl: '../assets/home/mainPost.html'
    controller: 'PostCtrl'
  }).otherwise( {
    templateUrl: '../assets/home/index.html'
    controller: 'IndexCtrl'
  })
]
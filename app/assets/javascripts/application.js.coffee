#= require turbolinks
# require bootstrap-sprockets
#= require angular
#= require angular-route
#= require_tree ./controllers/global

window.Sky = angular.module 'Sky', ['ngRoute', 'ngResource', 'ui.bootstrap']
Sky.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when('/post/:postId',  {
      templateUrl: '../assets/home/post.html'
      controller: 'Sky.postCtrl'
    }).otherwise( {
      templateUrl: '../assets/home/index.html'
      controller: 'indexCtrl'
    })
]
# require bootstrap-sprockets
#= require lazy
#= require angular
#= require angular-route
#= require angular-animate
#= require angularjs-rails-resource
#= require ui-bootstrap

window.Sky = angular.module 'Sky', ['ngRoute', 'rails', 'ui.bootstrap', 'ngAnimate']

Sky.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when('/', {
      templateUrl: '../assets/home/index.html'
      controller: 'Sky.indexCtrl'
    }).when('/sales', {
      templateUrl: '../assets/sales/home.html'
      controller: 'Sky.salesHomeCtrl'
      controllerAs: 'root'
    }).when('/post/:postId',  {
      templateUrl: '../assets/home/post.html'
      controller: 'Sky.postCtrl'
    }).otherwise( {
      templateUrl: '../assets/common/404.html'
    })
]

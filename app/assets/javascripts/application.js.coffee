# require bootstrap-sprockets
#= require lazy
#= require angular
#= require angular-route
# require angular-resource
#= require angularjs-rails-resource
#= require ui-bootstrap
#= require_self
#= require_tree ./controllers/global
#= require_tree ./services

window.Sky = angular.module 'Sky', ['ngRoute', 'rails', 'ui.bootstrap']

Sky.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when('/', {
    templateUrl: '../assets/home/index.html'
    controller: 'Sky.indexCtrl'
  }).when('/sales', {
    templateUrl: '../assets/sales/index.html'
    controller: 'Sky.salesIndexCtrl'
    controllerAs: 'root'
  }).when('/post/:postId',  {
    templateUrl: '../assets/home/post.html'
    controller: 'Sky.postCtrl'
  }).otherwise( {
    templateUrl: '../assets/common/404.html'
  })
]
# require bootstrap-sprockets
#= require lazy
#= require angular
#= require angular-route
#= require angular-resource
#= require ui-bootstrap
#= require_self
#= require_tree ./controllers/global
#= require_tree ./services

#Use PATCH as default for json's update method.
#defaults = $http.defaults.headers
#defaults.patch = defaults.patch || {}
#defaults.patch['Content-Type'] = 'application/json'

window.Sky = angular.module 'Sky', ['ngRoute', 'ngResource', 'ui.bootstrap']

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
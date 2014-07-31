#= require jquery
#= require globalize
#= require angular
#= require angular-sanitize
#= require angular-route
#= require angular-animate
#= require angularjs-rails-resource
#= require ui-bootstrap
#= require sugar
#= require xeditable
#= require moment
#= require dx.all

moment.lang 'vi'

window.Sky = angular.module 'Sky', ['ngRoute', 'rails', 'ui.bootstrap', 'ngAnimate', 'xeditable', 'dx']

Sky.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when('/', {
      templateUrl: '../assets/home/index.html'
      controller: 'Sky.indexCtrl'
    }).when('/sales', {
      templateUrl: '../assets/sales/home.html'
      controller: 'salesCtrl'
      controllerAs: 'salesCtrl'
    }).when('/post/:postId',  {
      templateUrl: '../assets/home/post.html'
      controller: 'Sky.postCtrl'
    }).when('/warehouse/import', {
      templateUrl: '../assets/warehouse/import.html',
      controller: 'importCtrl'
      controllerAs: 'importCtrl'
    }).otherwise( {
      templateUrl: '../assets/global/404.html'
    })
]

Sky.run (editableOptions) -> editableOptions.theme = 'bs3'

Sky.gs = (name) -> angular.element(document.body).injector().get(name)

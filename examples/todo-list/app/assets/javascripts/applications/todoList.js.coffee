# CLOUDSTORM
#= require cloudstorm

#SERVICES
#= require_tree ../services

#CONTROLLERS
#= require_tree ../controllers

# DIRECTIVES
#= require_tree ../directives

# RESOURCES
#= require_tree ../resources

# TEMPLATES
#= require_tree ../templates

todoList = angular.module("todoList", [
  "templates"
  "ngRoute"
  "ngResource"
  "ngAnimate"
  "ngSanitize"
  "ui.bootstrap"
  "ui.select"
  "ngDialog"
  "cloudStorm"
  "todoList.resources"
])
.config(["$routeProvider", ($routeProvider) ->
  $routeProvider.when("/items",
    templateUrl: "todo_list_index_base.html"
    controller: "ItemCtrl"
	).when("/users",
	  templateUrl: "todo_list_index_base.html"
	  controller: "UserCtrl"
	).when("/categories",
	  templateUrl: "todo_list_index_base.html"
	  controller: "CategoryCtrl"


  # ----- /CloudStorm ---------------------------

  ).otherwise redirectTo: "/items"

])

# ----- MAIN CONTROLLER -------------------------------------------------------

todoList.controller "MainCtrl", [ "$scope"
  ($scope) ->
    $scope.User = JSON.parse window.current_user
]


# ----- WAT? ------------------------------------------------------------------

angular.module('todoList.services').config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common['Accept'] = 'application/json, text/plain'])


# ----- CS CONFIG -------------------------------------------------------------

todoList.config([
  'csSettingsProvider', 'csLocalizationProvider'
  (csSettingsProvider, csLocalizationProvider) ->
    csSettingsProvider.set('date-format', 'yyyy-MM-dd')
    csSettingsProvider.set('time-zone-offset', '-1200')
    localization = csLocalizationProvider.$get()
    localization.add('false', '\u2718')
    localization.add('true',  '\u2713')
])

# ----- DEBUG INFO ------------------------------------------------------------

todoList.run ['$rootScope', ($rootScope) ->

  $rootScope.$on 'field-value-changed', () ->
    console.info 'field-value-changed event fired'

  $rootScope.$on 'submit-form-on-enter', () ->
    console.info 'submit-form-on-enter event fired'

  $rootScope.$on 'input-value-changed', () ->
    console.info 'input-value-changed event fired'

  $rootScope.$on 'form-cancel', () ->
    console.info 'form-cancel event fired'

  $rootScope.$on 'form-init', () ->
    console.info 'form-init event fired'

  $rootScope.$on 'form-submit', () ->
    console.info 'form-submit event fired'

  $rootScope.$on 'form-error', () ->
    console.info 'form-error event fired'

  $rootScope.$on 'wizard-canceled', () ->
    console.info 'wizard-canceled event fired'

  $rootScope.$on 'wizard-submited', () ->
    console.info 'wizard-submited event fired'

  $rootScope.$on 'wizard-finished', () ->
    console.info 'wizard-finished event fired'

  $rootScope.$on 'wizard-error', () ->
    console.info 'wizard-error event fired'

]
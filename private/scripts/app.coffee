unit = new (class Unit)

(() ->
  angular.module 'app', ['ui.router', 'ngResource', 'app.controllers']
  angular.module 'app.controllers', []

  appConfig = [
    '$stateProvider', '$urlRouterProvider',
    ($stateProvider ,  $urlRouterProvider) ->
      $urlRouterProvider.otherwise '/'

      DefaultResolver =
        'things': [
          '$stateParams', '$resource',
          ($stateParams ,  $resource) ->
            $resource '/api/req/:interval'
              .get
                interval: $stateParams.interval
              .$promise
        ]

      $stateProvider
      .state 'default',
        data:
          title: 'Landing Page'
        template:
          "<a style='display: block; width: 33.33%;' ui-sref='default.son({interval: 1000})'>Change route and wait 1 sec.</a>" +
          "<a style='display: block; width: 33.33%;' ui-sref='default.son({interval: 5000})'>Change route and wait 5 secs.</a>" +
          "<a style='display: block; width: 33.33%;' ui-sref='default.son({interval: 10000})'>Change route and wait 10 secs.</a>" +
          "<br />" +
          "<div data-ui-view/>"
        url: '/'			
      .state 'default.son',
        data:
          title: 'Not the landing page anymore'
        controller: [
          '$scope', 'things'
          ($scope ,  things) ->
            $scope.things = things
            unit
        ]
        resolve: DefaultResolver
        template: '{{things}}'
        url: '/:interval'
      unit
  ]

  appRun = [
    '$rootScope', '$state',
    ($rootScope , $state) ->
      $rootScope.$on '$stateChangeStart', (evt, to, toParams, from, fromParams) ->
        $rootScope.rootLoading = yes
        $rootScope.title = if to.data.title then "App - #{to.data.title}" else 'App'

        if to.name is 'default.son' and from.name is ''
          evt.preventDefault()
          $state.go 'default'

        unit

      $rootScope.$on '$stateChangeSuccess', () ->
        $rootScope.rootLoading = no

        unit

      $rootScope.$on '$stateChangeFailure', () ->
        $rootScope.rootLoading = no

        unit
      unit
  ]

  angular.module 'app'
    .config appConfig
    .run appRun

  unit
)()

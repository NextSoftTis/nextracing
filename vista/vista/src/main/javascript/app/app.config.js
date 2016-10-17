'use strict';
angular.module('nextracing')
    .config(['$locationProvider', '$routeProvider',
        function config($locationProvider, $routeProvider) {
            $routeProvider
                .when('/login', {
                    template: '<login></login>'
                })
                .when('/menu', {
                    template: '<menu></menu>'
                })

                .otherwise('/login');
        }
    ])
    .run(function (Auth, $rootScope, $location) {
        $rootScope.$on("$routeChangeStart", function (event, next, current) {
            if (Auth.getUsuarioLogeado() == null) {
                $location.path("/login");
            }
        })
    })
    .config(['RestangularProvider', function (RestangularProvider) {
        RestangularProvider.setBaseUrl('http://localhost:9999');
    }]);
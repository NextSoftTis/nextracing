'use strict';

angular.
module('nextracing.login').
component('login', {
    templateUrl: 'login/login.tpl.html',
    controller: ['Auth', '$location', '$cookies', function LoginController(Auth, $location, $cookies) {
        this.iniciarSesion = function(usuario) {

            Auth.login(usuario)
                .then(function(data) {
                    console.log('Success:' + data);
                    $location.path('/menu');
                })
                .catch(function(data) {
                    console.log('Fail');
                });
        };
    }]
});
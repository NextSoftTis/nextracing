'use strict';

angular.
module('nextracing.core.auth').
factory('Auth', ['Restangular', '$cookies', '$q',
    function(Restangular, $cookies, $q) {
        return {
            login: function(usuario) {
                return $q(function(resolve, reject) {
                    var usuarioModel = {
                        nombre : usuario
                    };
                    Restangular.all('login').post(usuarioModel)
                        .then(function(data) {
                            var usuarioModel = {
                                id: data.id,
                                nombre: data.nombre,
                                isLoggedIn: true,
                                token: 'Bearer ' + data.token
                            };
                            $cookies.putObject('usuario', usuarioModel);
                            Restangular.setDefaultHeaders({ Authorization: usuarioModel.token });
                            resolve(data);
                        })
                        .catch(function(data) {
                            reject(data);
                        });
                });
            },
            getUsuarioLogeado: function() {
                return $cookies.getObject('usuario');
            }
        };
    }
]);
'use strict';

angular.
    module('nextracing.menu').
    component('menu', {
        templateUrl: 'menu/menu.tpl.html',
        controller: ['Menu', '$location', '$cookies',
            function menuController(Menu, $location, $cookies) {
                var self = this;
                self.menus = [];
            }
        ]
    });
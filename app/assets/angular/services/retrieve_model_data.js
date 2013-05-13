'use strict';

var app = angular.module('app');

app.factory('Forum', function($resource) {
    return $resource('/forums/:id', {id: '@id'});
});

app.factory('Comment', function($resource) {
    return $resource('/forums/:forumId/comments/:id', {forumId: '@forumId', id: '@id'});
});



// The code should be pretty self explanatory (hopefully if you’re familiar with AngularJS).
// I’m basically setting up  a means to get ‘Forums’ & ‘Comments’.
// AngularJS requires that we specify the URL as well as any index identifiers (such as ‘id’) that is used to retrieve a specific object.
//
//
// Important: AngularJS does not have a analogous method for ‘update’.
// If you want to add update capability you’ll need to add {‘update’: {method: ‘PUT’}} to the actions parameter of the $resource object.
// We’re not updating anything here so I wont bother including that.

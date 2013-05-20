require
	baseUrl: '_example/scripts'

	paths:
		'lib': '../../lib'

	shim:
		'directives/todoBlur': deps: ['app']
		'directives/todoFocus': deps: ['app']
		'services/todoStorage': deps: ['app']
		'controllers/todoCtrl': deps: ['app', 'services/todoStorage']
		'app': deps: ['lib/angular/angular']
		'bootstrap': deps: ['app']

	[
		'require'
		'directives/todoBlur'
		'directives/todoFocus'
		'services/todoStorage'
		'controllers/todoCtrl'
	], (require) ->
		if document.readyState isnt 'complete'
			angular.element(document).ready ->
				require ['bootstrap']
		else
			require ['bootstrap']
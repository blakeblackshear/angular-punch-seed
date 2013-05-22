require
	baseUrl: '/_example/scripts'

	paths:
		'lib': '../../lib'

	shim:
		'components/todo-list/todoBlur': deps: ['app']
		'components/todo-list/todoFocus': deps: ['app']
		'services/todoStorage': deps: ['app']
		'components/todo-list/todoCtrl': deps: ['app', 'services/todoStorage', 'components/todo-list/todoBlur', 'components/todo-list/todoFocus']
		'app': deps: ['lib/angular/angular']
		'bootstrap': deps: ['app']

	[
		'require'
		'components/todo-list/todoCtrl'
	], (require) ->
		if document.readyState isnt 'complete'
			angular.element(document).ready ->
				require ['bootstrap']
		else
			require ['bootstrap']
tests = Object.keys(window.__karma__.files).filter (file) ->
      /base\/app\/_example.*\.js$/.test(file)

require.config
	baseUrl: '/base/app/_example/scripts'

	paths:
		'lib': '../../lib'
		'test': '../test'

	shim:
		'test/components/todo-list/todoCtrl': deps: ['components/todo-list/todoCtrl']
		'components/todo-list/todoBlur': deps: ['app']
		'components/todo-list/todoFocus': deps: ['app']
		'services/todoStorage': deps: ['app']
		'components/todo-list/todoCtrl': deps: ['app', 'services/todoStorage', 'components/todo-list/todoBlur', 'components/todo-list/todoFocus']
		'lib/angular-mocks/angular-mocks': deps: ['lib/angular/angular']
		'app': deps: ['lib/angular/angular', 'lib/angular-mocks/angular-mocks']
		'bootstrap': deps: ['app']

	callback: ->
		require [
			'app'
			'test/components/todo-list/todoCtrl'
		], ->
			window.__karma__.start()
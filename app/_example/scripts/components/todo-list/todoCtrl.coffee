class TodoCtrl
	@$inject: ['$scope', '$location', 'todoStorage', 'filterFilter']

	constructor: (@scope, @location, @todoStorage, @filterFilter) ->
		angular.extend @scope,
			newTodo: ""
			editedTodo: null
			location: @location
			addTodo: @addTodo
			editTodo: @editTodo
			doneEditing: @doneEditing
			removeTodo: @removeTodo
			clearCompletedTodos: @clearCompletedTodos
			markAll: @markAll

		@todos = @scope.todos = @todoStorage.get()

		@scope.$watch "todos", (=>
			@scope.remainingCount = @filterFilter(@todos,
				completed: false
			).length
			@scope.completedCount = @todos.length - @scope.remainingCount
			@scope.allChecked = not @scope.remainingCount
			@todoStorage.put @todos
		), true

		@location.path "/"  if @location.path() is ""

		@scope.$watch "location.path()", (path) =>
			@scope.statusFilter = (if (path is "/active") then completed: false else (if (path is "/completed") then completed: true else null))

	addTodo: =>
		return unless @scope.newTodo.length
		@todos.push
			title: @scope.newTodo
			completed: false

		@scope.newTodo = ""

	editTodo: (todo) =>
		@scope.editedTodo = todo

	doneEditing: (todo) =>
		@scope.editedTodo = null
		@scope.removeTodo todo  unless todo.title

	removeTodo: (todo) =>
		@todos.splice @todos.indexOf(todo), 1

	clearCompletedTodos: =>
		@scope.todos = @todos = @todos.filter((val) ->
			not val.completed
		)

	markAll: (completed) =>
		@todos.forEach (todo) ->
			todo.completed = completed

angular.module('app').controller 'TodoCtrl', TodoCtrl
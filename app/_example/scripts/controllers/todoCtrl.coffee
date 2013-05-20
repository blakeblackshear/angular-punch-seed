angular.module('app').controller 'TodoCtrl', ['$scope', '$location', 'todoStorage', 'filterFilter', ($scope, $location, todoStorage, filterFilter) ->
	todos = $scope.todos = todoStorage.get()
	$scope.newTodo = ""
	$scope.editedTodo = null
	$scope.$watch "todos", (->
		$scope.remainingCount = filterFilter(todos,
			completed: false
		).length
		$scope.completedCount = todos.length - $scope.remainingCount
		$scope.allChecked = not $scope.remainingCount
		todoStorage.put todos
	), true
	$location.path "/"  if $location.path() is ""
	$scope.location = $location
	$scope.$watch "location.path()", (path) ->
		$scope.statusFilter = (if (path is "/active") then completed: false else (if (path is "/completed") then completed: true else null))

	$scope.addTodo = ->
		return  unless $scope.newTodo.length
		todos.push
			title: $scope.newTodo
			completed: false

		$scope.newTodo = ""

	$scope.editTodo = (todo) ->
		$scope.editedTodo = todo

	$scope.doneEditing = (todo) ->
		$scope.editedTodo = null
		$scope.removeTodo todo  unless todo.title

	$scope.removeTodo = (todo) ->
		todos.splice todos.indexOf(todo), 1

	$scope.clearCompletedTodos = ->
		$scope.todos = todos = todos.filter((val) ->
			not val.completed
		)

	$scope.markAll = (completed) ->
		todos.forEach (todo) ->
			todo.completed = completed
]
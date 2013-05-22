describe 'Controller: todoCtrl', ->
	scope = TodoCtrl = null

	beforeEach module 'app'
	
	beforeEach inject ($controller, $rootScope) ->
		scope = $rootScope.$new()
		TodoCtrl = $controller 'TodoCtrl',
			$scope: scope

	it 'should have a new todo as empty', ->
		expect(scope.newTodo).toBe ''

	it 'should have no todos', ->
		expect(scope.todos.length).toBe 0

	it 'should add a todo', ->
		scope.newTodo = 'New Todo'
		scope.addTodo()

		expect(scope.todos.length).toBe 1
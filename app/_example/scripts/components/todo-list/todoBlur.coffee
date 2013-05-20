angular.module('app').directive 'todoBlur', ->
	(scope, elem, attrs) ->
		elem.bind 'blur', ->
			scope.$apply attrs.todoBlur
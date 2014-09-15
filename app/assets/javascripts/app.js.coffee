# Define App and dependencies
ToDoApp = angular.module("ToDoApp", ["ngRoute", "templates"])

# Setup the angular router
ToDoApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider
   .when '/',
      templateUrl: "index.html",
      controller: "TodosCtrl"
  .otherwise
      redirectTo: "/"

  $locationProvider.html5Mode(true).hashPrefix("#")
]

# todos Controller
ToDoApp.controller "TodosCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.todos = []

  $scope.gettodos = ->
  # make a GET request to /todos.json
    $http.get("/todos.json").success (data) ->
      $scope.todos = data

  $scope.gettodos()

  # CREATE
  $scope.addToDo = ->
    $http.post("/todos.json", $scope.newToDo).success (data) ->
      $scope.newToDo = {}
      $scope.todos.push(data)

  # DELETE
  $scope.deleteToDo = (todo) ->
    conf = confirm "Are you sure?"
    if conf
      $http.delete("/todos/#{todo.id}.json").success (data) ->
        $scope.todos.splice($scope.todos.indexOf(todo),1)

  # CHANGE STATUS
  $scope.markCompleted = (todo) ->
    console.log todo.checked
    todo.completed = todo.completed == false ? true: false;
    todo.checked = todo.completed == false ? false: true;

    $http.put("/todos/#{todo.id}.json", todo).success (data) ->
  # OPEN EDITING FORM
  $scope.openForm = () ->
    this.editing = true
    this.viewing = true
  # EDIT
  $scope.editToDo = (todo) ->
    this.editing = false
    this.viewing = false
    $http.put("/todos/#{todo.id}.json", todo).success (data) ->
]

# Define Config for CSRF token
ToDoApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
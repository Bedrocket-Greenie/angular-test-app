#Bootstraps the angular project
app = angular.module("Raffler", ["ngResource"])

app.factory "Entry", ["$resource", ($resource) ->
  $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}})
]

# $scope is what lets us bind data to elements in the UI.
app.controller 'RaffleCtrl', ["$scope", "Entry", ($scope, Entry) -> # <-- Defining a controller on an module to avoid global namespacing.
  $scope.entries = Entry.query()

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry)
    $scope.entries.push(entry)
    $scope.newEntry = {}

  $scope.drawWinner = ->
    pool = []
    angular.forEach $scope.entries, (entry) ->
      pool.push(entry) if !entry.winner
    if pool.length > 0
      entry = pool[Math.floor(Math.random()*pool.length)]
      entry.winner = true
      entry.$update()
      $scope.lastWinner = entry

]
# Controllers are classes or types that write to tell Angular 
# which object or primitives make up your model by assigning them to the $scope
# object passed into your controller.
@FirstCtrl = ["$scope", ($scope) ->
  $scope.animals = []

  $scope.addName = ->
    $scope.animals.push($scope.animal)
    $scope.animal = {}
]

app.factory "Person", ["$resource", ($resource) ->
  $resource("/people/:id", {id: "@id"}, {update: {method: "PUT"}})
]

@SecCtrl = ["$scope", "Person", ($scope, Person) ->
  $scope.persons = Person.query()

  $scope.addName = ->
    newPersonName = Person.save($scope.newPerson)
    $scope.persons.push(newPersonName)
    $scope.newEntry = {}
]

# Angular Services. Sharing data between 2 different controllers
app.factory("Data", ()->
    return { message: "Data from a service" }
)

@SharedCtrlOne = ["$scope", "Data", ($scope, Data) ->
  $scope.data = Data
]

@SharedCtrlTwo = ["$scope", "Data", ($scope, Data) ->
  $scope.data = Data

  #Defining a method on a scope
  $scope.reversedMessage = (message) ->
    return message.split("").reverse().join("")
]

app.controller "StartUpController", ["$scope", ($scope) ->
  $scope.funding = { startingEstimate: 0 } 

  $scope.computeTotal = ->
    $scope.funding.needed = $scope.funding.startingEstimate * 10
]

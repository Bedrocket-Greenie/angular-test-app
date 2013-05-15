app = angular.module("Raffler", ["ngResource"])

app.factory "Entry", ["$resource", ($resource) ->
  $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}})
]

@RaffleCtrl = ["$scope" , "Entry", ($scope, Entry) ->
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

# Controllers according to egg.io
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
    return { message: "I'm data from a service" }
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

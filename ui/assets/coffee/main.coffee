app = angular.module "app", ['restangular']

app.factory "AuthInterceptor", ($window, $q) ->
	request: (config) ->
		config.headers = config.headers or {}
		# Set the token in the header
		config.headers["brightpearl-app-ref"] = "jonprod_scanly"
		config.headers["brightpearl-account-token"] = "H5uk2+Onjbbc6JrWbBXrOMe+Qrs9Qf2IzkIyc1Vhq+g="
		config or $q.when(config)

	response: (response) ->
		response or $q.when(response)

# Add the auth header injector for all requests
app.config ($httpProvider) ->
	# Handle tokens
	$httpProvider.interceptors.push "AuthInterceptor"
	# Hadnle -domain requests
	$httpProvider.defaults.useXDomain = true
	delete $httpProvider.defaults.headers.common['X-Requested-With']


app.controller "HomeCtrl", ($scope, $filter, $http) ->

  $scope.product = null

  $scope.sku = null
  $scope.cachedProducts = []
  $scope.resultsssss = null

  $scope.searchProducts = (server) ->
	console.log(server)

	# this callback will be called asynchronously
	# when the response is available
	$http(
	   method: "GET"
	   url: "https://ws-eu1.brightpearl.com/public-api/jonprod/product-service/product/1000-1010"
	 ).success (data, status, headers, config) ->
		$scope.resultsssss = data

  $scope.scan = () ->
	$scope.searchProducts()


  $scope.reset = () ->
	$scope.product = null
	$scope.sku = null

  products = [
	 {name : "My product", sku: "1", onHand: 10, originalValue: 10},
	 {name : "My product 2", sku: "2", onHand: 10, originalValue:10},
  ]

 app.directive "focusme",
	-> (node, element) ->
	  element[0].focus()

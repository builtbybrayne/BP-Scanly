# BASE SETUP
# =============================================================================

# call the packages we need
express = require("express")
bodyParser = require("body-parser")
request = require "superagent"
app = express()

# configure app
app.use bodyParser()
port = process.env.PORT or 8080 # set our port

# ROUTES FOR OUR API
# =============================================================================

# create our router
router = express.Router()

# middleware to use for all requests
router.use (req, res, next) ->
  console.log "Something is happening."
  next()


# test route to make sure everything is working (accessed at GET http://localhost:8080/api)
#router.route("/").get (req, res) ->
#  res.json message: "hooray! welcome to our apis!"


# on routes that end in /bears
# ----------------------------------------------------

# get all the bears (accessed at GET http://localhost:8080/api/bears)
router.route("/api").get (req, res) ->
  request
    .get("https://ws-eu1.brightpearl.com/public-api/jonprod/product-service/product-search?SKU=" + req.query.sku)
    .set('Accept', 'application/json')
    .set("brightpearl-app-ref", "jonprod_scanly")
    .set("brightpearl-account-token", "H5uk2+Onjbbc6JrWbBXrOMe+Qrs9Qf2IzkIyc1Vhq+g=")
    .end (results) ->
      res.send results.body
      
router.route("/").get (req, res) ->
  res.send {}

# REGISTER OUR ROUTES -------------------------------
app.use "/", router

# START THE SERVER
# =============================================================================
app.listen port
console.log "Magic happens on port " + port


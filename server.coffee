# BASE SETUP
# =============================================================================

# call the packages we need
express = require("express")
bodyParser = require("body-parser")
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
router.route("/").get (req, res) ->
  res.json message: "hooray! welcome to our apis!"


# on routes that end in /bears
# ----------------------------------------------------

# get all the bears (accessed at GET http://localhost:8080/api/bears)
router.route("/products").get (req, res) ->
  res.json message: "hooray! welcome to our api!"



# REGISTER OUR ROUTES -------------------------------
app.use "/api", router

# START THE SERVER
# =============================================================================
app.listen port
console.log "Magic happens on port " + port


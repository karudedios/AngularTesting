express = require 'express'

app = express()
router = express.Router()

router.get '/api/req/:interval',
  (req, res) ->
    setTimeout(
      () ->
        res.send
          loaded: yes
          message: 'success'
          interval: +req.params.interval
      req.params.interval or 0
    )

app
	.use '/styles', express.static("#{__dirname}/public/styles")
	.use '/scripts', express.static("#{__dirname}/public/scripts")
	.use '/fonts', express.static("#{__dirname}/public/fonts")
	.use '/templates', express.static("#{__dirname}/public/templates")
	.use '/bower_components', express.static("#{__dirname}/bower_components")
	.use router
	
app.get '/',
  (req, res) ->
    res.sendFile("#{__dirname}/public/templates/index.html")

app.listen 3000
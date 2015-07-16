express = require 'express'

app = express()
router = express.Router()

router.get '/req',
	(res, req) ->
		setTimeout(
			() ->
				res.send("Yay.")
			5000
		)

app
	.use('/', express.static(__dirname + '/public/templates/index.html'))
	.use('/styles', express.static(__dirname + '/public/styles'))
	.use('/scripts', express.static(__dirname + '/public/scripts'))
	.use('/fonts', express.static(__dirname + '/public/fonts'))
	.use('/templates', express.static(__dirname + '/public/templates'))
	.use(router);

app.listen(3000);
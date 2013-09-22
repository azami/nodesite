express = require('express')
routes = require('./routes')
#novel = require('./routes/novel')
memo = require('./routes/api/memo')
auth = require('./modules/auth')

http = require('http')
path = require('path')

app = express()

app.set('port', process.env.PORT || 3000)
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')
app.use(express.favicon())
app.use(express.logger('dev'))
app.use(express.bodyParser())
app.use(express.methodOverride())
app.use(app.router)
app.use(express.static(path.join(__dirname, 'public')))

#if 'development' == app.get('env')
app.use(express.errorHandler())

app.all('/edit/*', auth.requireAuthentication)
app.all('/api/edit/*', auth.requireAuthentication)

app.get('/', routes.index)
app.get('/memo', routes.memo)
app.get('/memo:page', routes.memo)

# apis
app.get('/api/memo', memo.list)

# author
app.post('/api/edit/memo/write', memo.write)

#app.get('/novel', routes.novel)

http.createServer(app).listen(app.get('port'), console.log('Express server listening on port ' + app.get('port')))

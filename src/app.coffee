express = require('express')
routes = require('./routes')
#novel = require('./routes/novel')
memo = require('./routes/api/memo')
admin = require('./routes/admin')
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
app.use('/static', express.static(path.join(__dirname, 'static')))
app.use('/uploads', express.static(path.join(__dirname, 'uploads')))
app.use(app.router)

#if 'development' == app.get('env')
app.use(express.errorHandler())

app.all('/admin/*', auth.requireAuthentication)
app.all('/api/admin/*', auth.requireAuthentication)

app.get('/', routes.index)
app.get('/memo', routes.memo)
app.get('/memo:page', routes.memo)

# apis
app.get('/api/memo', memo.list)

# admin
app.get('/admin/memo', admin.memo)
app.post('/api/admin/memo/write', memo.write)

#app.get('/novel', routes.novel)

http.createServer(app).listen(app.get('port'), console.log('Express server listening on port ' + app.get('port')))

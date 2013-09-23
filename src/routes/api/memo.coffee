memo = require('../../modules/memo')

exports.write = (req, res) ->
  try
    memo.write req.body
    res.send 201
  catch error
    console.log("#{error}")

exports.list = (req, res) ->
  res.set 'Content-Type', 'applicationres/json'
  memo.read (err, data) ->
    if err
      res.send 503
    if !data
      res.send 404
    res.send JSON.stringify(data)

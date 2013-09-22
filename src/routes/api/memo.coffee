memo = require('../../modules/memo')

exports.write = (req, res) ->
  try
    memo.write req.body
    res.send 201
  catch error
    console.log("#{error}")

exports.list = (req, res) ->
  memo.get (err, data) ->
    console.log err if err
    data.forEach (doc) ->
      console.log(doc)
    res.send 200

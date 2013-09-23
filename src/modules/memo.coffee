mongoose = require 'mongoose'

mongoose.connect(
  'mongodb://localhost/',
   (err) ->
     if err then throw err
)

process.on 'SIGINT', ->
  mongoose.disconnect()

Schema = mongoose.Schema

memoSchema = new Schema {
  title: {
    type: String
    required: true
  }
  article: {
    type: String
    required: true
  }
  pic: String
  datetime: {
    type: Date
    default: Date.now
  }
}

Memo = mongoose.model('Memo', memoSchema)

onError = (err, callback) ->
  mongoose.connection.close()
  callback err

exports.write = (params) ->
    new Memo(params).save((err) -> done(err) if err)

exports.read = (callback, limit=10, skip=1) ->
  Memo.find({})\
    .sort({datetime: -1})\
    .skip(skip - 1)\
    .limit(limit)\
    .exec(callback)

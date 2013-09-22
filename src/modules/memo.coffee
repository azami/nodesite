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
  title: String
  article: String
  img: Buffer
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

exports.fetch = (callback, limit=10, sort=1) ->
  Memo.find({})\
    .sort({datetime: -1})\
    .skip(skip - 1)\
    .limit(limit)\
    .exec((err, data) ->
      for d in data
        console.log d
    )

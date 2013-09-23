mongoose = require 'mongoose'

mongoose.connect(
  'mongodb://localhost/',
   (err) ->
     if err then throw err
)

process.on 'SIGINT', ->
  mongoose.disconnect()

Schema = mongoose.Schema

NovelSchema = new Schema {
  url: {
    type: String
    required: true
  }
  title: {
    type: String
    required: true
  }
  sysnopsis: String
  completion: {
    type: Boolean
    default: false
  }
  datetime: {
    type: Date
    default: Date.now
  }
  articles: [
    {
      subtitle: {
        type: String
        required: true
      }
      article: {
        type: String
        required: true
      }
      datetime: {
        type: Date
        default: Date.now
      }
    }
  ]
}


Novel = mongoose.model('Novel', memoSchema)

onError = (err, callback) ->
  mongoose.connection.close()
  callback err

exports.create = (url, title, sysnopsis, completion=false) ->
  new Novel({
    url: url
    title: title
    sysnopsis: sysnopsis
    completion: completion
  }).save((err) -> done(err) if err)

exports.read = (callback, limit=10, skip=1) ->
  Memo.find({})\
    .sort({datetime: -1})\
    .skip(skip - 1)\
    .limit(limit)\
    .exec(callback)

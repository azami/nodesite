mongoose = require('mongoose')
Schema = mongoose.Schema

novelSchema = new Schema {
  url: String
  title: String
  sysnopsis: String
  completion: Boolean
  datetime: {
    type: Date
    default: Date.now
  }
  articles: [
    {
      subtitle: String
      article: String
      datetime: {
        type: Date
        default: Date.now
      }
    }
  ]
}

memoSchema = new Schema {
  title: String
  article: String
  img: Buffer
  datetime: {
    type: Date
    default: Date.now
  }
}

logSchema = new Schema {
  ip: String
  ua: String
  url: String
  referer: String
  datetime: {
    type: Date
    default: Date.now
  }
}

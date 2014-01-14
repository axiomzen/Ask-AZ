client = require('redis').createClient()

exports.index = (req, res) ->
  res.render "index"

exports.ask = (req, res) ->
  q = req.body.question
  client.lpush 'questions', q, (err, count) ->
    res.render "thanks",
      question: q
      count: count

exports.next = (req, res) ->
  client.rpop 'questions', (err, q) ->
    client.llen 'questions', (err, count) ->
      res.render "question",
        question: q
        count: count

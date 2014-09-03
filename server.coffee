
server = require 'ws-json-server'

db = require './src/db'

server.listen 3004, (ws) ->

  ws.on 'login', (data, res) ->
    db.findOne 'user', data, (user) ->
      if user?
        console.log 'operate:', user
        ws.emit 'operate', key: 'user', action: 'set', data: user
      else
        res error: 'No such user'

  ws.on 'signup', (data, res) ->
    db.findOne 'user', data, (user) ->
      if user?
        res error: 'Name is already used'
      else
        data.profile =
          nickname: '<nickname>'
          avatar: 'http://tp2.sinaimg.cn/1668244557/180/1285301721/1'
        db.add 'user', data
        ws.emit 'operate', key: 'user', action: 'set', data: data
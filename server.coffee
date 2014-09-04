
server = require 'ws-json-server'
objectid = require 'objectid'
db = require './src/db'

server.listen 3004, (ws) ->

  operate = (key, action, data) ->
    ws.emit 'operate', {key, action, data}

  ws.on 'login', (data, res) ->
    db.findOne 'user', data, (user) ->
      if user?
        console.log 'operate:', user
        ws.emit 'operate', key: 'user', action: 'set', data: user
        console.log db.get('teams')
        operate 'teams', 'set', db.get('teams')
        res success: yes
      else
        res error: 'No such user'

  ws.on 'signup', (data, res) ->
    db.findOne 'user', data, (user) ->
      if user?
        res error: 'Name is already used'
      else
        data.id = objectid()
        data.profile =
          nickname: '<nickname>'
          avatar: 'http://tp2.sinaimg.cn/1668244557/180/1285301721/1'
        db.add 'user', data
        res success: yes
        operate 'user', 'set', data
        operate 'teams', 'set', db.get('teams')

  ws.on 'create-team', (data, res) ->
    data.id = objectid()
    db.add 'teams', data
    res success: yes
    operate 'teams', 'add', data

  ws.on 'update-team', (data, res) ->
    unless data.id?
      res error: 'No team id'
      return
    db.update 'teams', data
    res success: yes
    operate 'teams', 'update', data

  ws.on 'remove-team', (id, res) ->
    db.remove 'teams', id
    res success: yes
    operate 'teams', 'remove', id
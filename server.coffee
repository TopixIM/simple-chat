
server = require 'ws-json-server'
objectid = require 'objectid'
db = require './src/db'

allUsers = {}

server.listen 3004, (ws) ->

  state =
    ws: ws
    teamId: null
    roomId: null

  addUser = ->
    allUsers[state.id] = state
  ws.onclose ->
    delete allUsers[state.id]

  operate = (key, action, data) ->
    ws.emit 'operate', {key, action, data}

  operateAll = (key, action, data) ->
    for _, account of allUsers
      account.ws.emit 'operate', {key, action, data}

  operateTeam = (key, action, data) ->
    for _, account of allUsers
      if account.teamId is state.teamId
        account.ws.emit 'operate', {key, action, data}

  operateRoom = (key, action, data) ->
    for _, account of allUsers
      if account.roomId is state.roomId
        account.ws.emit 'operate', {key, action, data}

  ws.on 'login', (data, res) ->
    db.findOne 'user', data, (user) ->
      if user?
        ws.emit 'operate', key: 'user', action: 'set', data: user
        operate 'teams', 'set', db.get('teams')
        state.id = user.id
        addUser()
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
        console.log 'add user', data
        state.id = data.id
        addUser()
        res success: yes
        operate 'user', 'set', data
        operate 'teams', 'set', db.get('teams')

  ws.on 'create-team', (data, res) ->
    data.id = objectid()
    db.add 'teams', data
    res success: yes
    operateTeam 'teams', 'add', data

  ws.on 'update-team', (data, res) ->
    unless data.id?
      res error: 'No team id'
      return
    db.update 'teams', data
    res success: yes
    operateTeam 'teams', 'update', data

  ws.on 'remove-team', (id, res) ->
    db.remove 'teams', id
    res success: yes
    operateTeam 'teams', 'remove', id

  ws.on 'open-team', (id, res) ->

  ws.on 'update-profile', (data, res) ->
    db.update 'user', data
    operate 'user', 'set', data
    res success: yes
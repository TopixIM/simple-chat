
server = require 'ws-json-server'

users = require './src/users'

server.listen 3004, (ws) ->

  ws.on 'login', (data, res) ->
    user = users.get data.name, data.password
    if user?
      ws.emit 'user', data
    else
      res error: 'No such user'

  ws.on 'signup', (data, res) ->
    user = users.get data.name, data.password
    if user
      res error: 'Name is already used'
    else
      users.create data
      ws.emit 'user', data
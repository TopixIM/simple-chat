
server = require 'ws-json-server'

server.listen 3004, (ws) ->
  ws.on 'greet', (data, res) ->
    console.log 'on greet', data
    res 'greet too'
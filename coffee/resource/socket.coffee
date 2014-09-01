
client = require 'ws-json-browser'
{EventEmitter} = require 'events'

callbacks = []

scope =
  send: ->
    alert "socket is not ready"

client.connect 'localhost', 3004, (ws) ->

  scope.send = (all...) -> ws.emit all...

  while callbacks.length
    cb = callbacks.pop()
    cb(ws)

exports.send = (all...) -> scope.send all...

exports.onload = (f) ->
  callbacks.push (f)
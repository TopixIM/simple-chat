
Dispatcher = require './utils/dispatcher'

module.exports = store = new Dispatcher
client = require './resource/socket'

store.data =
  teams: []
  rooms: []
  users: []
  messages: []
  user: undefined
  state:
    teamId: undefined
    roomId: undefined
    contactId: undefined

client.onload (ws) ->
  ws.on 'user', (data) ->
    store.data.user = data
    store.emit 'user'

store.getData = ->
  @data

store.getState = ->
  @data.state

store.getUser = ->
  @data.user

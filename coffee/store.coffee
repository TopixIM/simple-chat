
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
  ws.on 'operate', (message) ->
    {key, action, data} = message
    console.log "operate: #{key}, #{action}:", data
    switch action
      when 'set'
        store.data[key] = data
      when 'append'
        unless store.data[key]
          store.data[key] = []
        store.data[key].push data
      when 'delete'
        store.data[key] = null
      else
        console.warn "unhandled action: #{action}"
        return
    store.emit()

store.getData = ->
  @data

store.getState = ->
  @data.state

store.getUser = ->
  @data.user

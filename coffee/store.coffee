
Dispatcher = require './utils/dispatcher'

module.exports = store = new Dispatcher
client = require './resource/socket'

store.data =
  teams: {}
  rooms: {}
  users: {}
  messages: {}
  user: undefined
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
      when 'add'
        unless store.data[key] then store.data[key] = {}
        store.data[key][data.id] = data
      when 'delete'
        store.data[key] = null
      when 'remove'
        store.data[key][data] = null
        delete store.data[key][data]
      when 'update'
        store.data[key][data.id] = data
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

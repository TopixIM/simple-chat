
Dispatcher = require './utils/dispatcher'

module.exports = store = new Dispatcher
client = require './resource/socket'

store.data =
  teams: {}
  rooms: {}
  users: {}
  messages: {}
  user: null
  teamId: null
  roomId: null

client.onload (ws) ->
  ws.on 'operate', (message) ->
    {key, action, data} = message
    console.log "~~>\t#{action}\t#{key}\t~~>", data
    switch action
      when 'set'
        store.data[key] = data
      when 'add'
        unless store.data[key] then store.data[key] = {}
        store.data[key][data.id] = data
      when 'delete'
        delete store.data[key]
      when 'remove'
        delete store.data[key][data]
      when 'update'
        store.data[key][data.id] = data
      else
        console.warn "unhandled action: #{action}"
        return
    store.emit()

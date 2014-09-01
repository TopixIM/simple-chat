
React = require 'react'
client = require 'ws-json-browser'

$ = React.DOM

AppViewComponent = require './component/app-view'
Store = require './store'

store = new Store

client.connect 'localhost', 3004, (ws) ->
  ws.emit 'greet', 'from client', (data) ->
    console.log 'from server', data

React.renderComponent AppViewComponent(data: store.getData()),
  document.body
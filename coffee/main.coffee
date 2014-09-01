
React = require 'react'
client = require 'ws-json-browser'

AppViewComponent = require './component/app-view'
store = require './store'

React.renderComponent AppViewComponent(data: store.getData()),
  document.body

React = require 'react'
client = require 'ws-json-browser'

AppViewComponent = require './component/app-view'
store = require './store'

renderPage = ->
  React.renderComponent AppViewComponent(data: store.data),
    document.body

store.addChangeListener renderPage

renderPage()
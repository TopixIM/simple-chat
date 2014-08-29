
require './utils/extend'
React = require 'react'

AppComponent = require './component/app'
siteStore = require './store/messages'

React.renderComponent AppComponent({data: siteStore.get()}),
  document.body
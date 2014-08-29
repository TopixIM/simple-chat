
React = require 'react'

module.exports = React.createClass
  displayName: 'App'

  render: ->
    $.div
      className: 'app-component'
      'app'
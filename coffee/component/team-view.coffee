
React = require 'react'

$ = React.DOM

module.exports = React.createClass
  displayName: 'team-view'

  render: ->
    $.div
      className: 'team-view'
      'team-view here'
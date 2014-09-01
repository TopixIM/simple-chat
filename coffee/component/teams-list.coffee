
React = require 'react'

$ = React.DOM

module.exports = React.createClass
  displayName: 'teams-list'

  render: ->
    $.div
      className: 'teams-list'
      'teams-list here'
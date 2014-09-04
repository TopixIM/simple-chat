
React = require 'react'

socket = require '../resource/socket'

$ = React.DOM

module.exports = React.createClass
  displayName: 'team-title'

  onClick: ->
    @props.introduceTeam @props.data

  render: ->
    $.div className: 'team-title',
      $.div
        className: 'logo'
        style:
          backgroundImage: "url('#{@props.data.logo}')"
      $.div className: 'name',
        @props.data.name
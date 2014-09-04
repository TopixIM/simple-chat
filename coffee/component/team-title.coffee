
React = require 'react'

socket = require '../resource/socket'

$ = React.DOM
$$ = require '../utils/helper'

module.exports = React.createClass
  displayName: 'team-title'

  onClick: (event) ->
    @props.introduceTeam @props.data

  openTeam: (event) ->
    event.stopPropagation()
    socket.send 'open-team', @props.data.id

  render: ->
    $.div className: 'team-title', onClick: @onClick,
      $.a
        className: 'logo avatar'
        style:
          backgroundImage: "url('#{@props.data.logo}')"
      $.span className: 'name',
      $$.if @props.data.link,
        => $.a className: 'link', target: '_blank', href: @props.data.link, @props.data.name
      $.span className: 'desc', @props.data.desc
      $.div className: 'button', onClick: @openTeam, 'Open'
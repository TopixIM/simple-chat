
React = require 'react'

$ = React.DOM

module.exports = React.createClass
  displayName: 'user-panel'
  render: ->
    $.div
      className: 'user-panel'
      $.div
        className: 'avatar', title: @props.store
        style:
          backgroundImage: "url(#{@props.data.profile.avatar})"
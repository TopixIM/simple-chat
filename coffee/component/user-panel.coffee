
React = require 'react'

$ = React.DOM

module.exports = React.createClass
  displayName: 'user-panel'
  render: ->
    $.div
      className: 'user-panel'
      $.div
        className: 'user-avatar'
        title: ''
        style:
          backgroundImage: "url(#{@props.data.profile.avatar})"
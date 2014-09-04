
React = require 'react'

socket = require '../resource/socket'

$ = React.DOM
$$ = require('../utils/helper')

module.exports = React.createClass
  displayName: 'team-detail'

  getInitialState: ->
    nameError: null
    actionError: null

  publishTeam: ->
    @setState nameError: null
    name = @refs.name.getDOMNode().value.trim()
    if name.length is 0
      @setState nameError: 'Name is empty'
      return
    logo = @refs.logo.getDOMNode().value.trim()
    desc = @refs.desc.getDOMNode().value.trim()
    if @props.currentTeam?
      id = @props.currentTeam
      socket.send 'update-team', {id, name, logo, desc}, (resp) =>
        @setState actionError: resp.error
    else
      socket.send 'create-team', {name, logo, desc}

  render: ->
    $.div className: 'team-detail',
      $.div className: 'grid-row',
        $.div className: 'entity', 'Name'
        $.div className: 'wrapper',
          $.input className: 'content main', ref: 'name'
          $$.if @state.nameError?,
            => $.div className: 'label is-error', @state.nameError
      $.div className: 'grid-row',
        $.div className: 'entity', 'Logo'
        $.input className: 'content', ref: 'logo', placeholder: 'Url', type: 'url'
      $.div className: 'grid-row',
        $.div className: 'entity', 'Description'
        $.input className: 'content', ref: 'desc'
      $.div className: 'grid-row',
        $.div className: 'entity', 'link'
        $.input className: 'content', ref: 'link', placeholder: 'Link', type: 'url'
      $.div {},
        $.div className: 'button main', onClick: @publishTeam, 'Submit'
        $$.if @state.actionError?,
          => $.span className: 'label is-error', @state.actionError
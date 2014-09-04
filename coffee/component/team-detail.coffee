
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
    link = @refs.link.getDOMNode().value.trim()
    if @props.data.id?
      id = @props.data.id
      socket.send 'update-team', {id, name, logo, desc, link}, (resp) =>
        if resp.error?
          @setState actionError: resp.error
        else if resp.success then @endEditing()
    else
      socket.send 'create-team', {name, logo, desc, link}, (resp) =>
        if resp.success then @endEditing()

  componentDidMount: ->
    @fillInData()

  componentDidUpdate: ->
    @fillInData()

  fillInData: ->
    data = @props.data
    @refs.name.getDOMNode().value = data.name or ''
    @refs.logo.getDOMNode().value = data.logo or ''
    @refs.desc.getDOMNode().value = data.desc or ''
    @refs.link.getDOMNode().value = data.link or ''

  removeTeam: ->
    socket.send 'remove-team', @props.data.id, (resp) =>
      if resp.success then @endEditing()

  endEditing: ->
    @props.endEditing()

  render: ->
    $.div className: 'team-detail',
      $.div className: 'header',
        $.span className: 'entry-text', onClick: @endEditing, 'Close'
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
        $$.if @props.data?.id?,
          => $.div className: 'button is-danger', onClick: @removeTeam, 'Remove'
        $$.if @state.actionError?,
          => $.span className: 'label is-error', @state.actionError
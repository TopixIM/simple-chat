
React = require 'react'

socket = require '../resource/socket'

$ = React.DOM
$$ = require '../utils/helper'

module.exports = React.createClass
  displayName: 'profile-editor'

  getInitialState: ->
    nameError: null
    actionError: null

  endEditing: ->
    @props.endEditing()

  componentDidMount: ->
    data = @props.data
    @refs.name.getDOMNode().value = data.name or ''
    @refs.avatar.getDOMNode().value = data.avatar or ''
    @refs.about.getDOMNode().value = data.about or ''
    @refs.site.getDOMNode().value = data.site or ''

  updateProfile: ->
    @setState actionError: null, nameError: null
    name = @refs.name.getDOMNode().value.trim()
    if name.length is 0
      @setState nameError: 'Name is empty'
      return
    avatar = @refs.avatar.getDOMNode().value.trim()
    about = @refs.about.getDOMNode().value.trim()
    site = @refs.site.getDOMNode().value.trim()
    id = @props.data.id
    socket.send 'update-profile', {id, name, avatar, about, site}, (resp) =>
      if resp.error? then @setState nameError: resp.error
      else if resp.success then @endEditing()

  render: ->
    $.section className: 'profile-editor light-box grid-center',
      $.div className: 'card',
        $.div className: 'header',
          $.span {}, 'Edit user'
          $.span className: 'entry-text is-right', onClick: @endEditing, 'Close'
        $.div className: 'body',
          $.div className: 'grid-row',
            $.div className: 'entity', 'Name'
            $.div className: 'wrapper',
              $.input className: 'content main', ref: 'name'
              $$.if @state.nameError?,
                => $.span className: 'label is-error', @state.nameError
          $.div className: 'grid-row',
            $.div className: 'entity', 'Avatar'
            $.input className: 'content', ref: 'avatar', type: 'url', placeholder: 'Url of avatar'
          $.div className: 'grid-row',
            $.div className: 'entity', 'About'
            $.input className: 'content', ref: 'about'
          $.div className: 'grid-row',
            $.div className: 'entity', 'Site'
            $.input className: 'content', ref: 'site', type: 'url', placeholder: 'Url of site'
          $.div className: 'actions',
            $.span className: 'button', onClick: @updateProfile, 'Save'
            $$.if @state.actionError?,
              $.span className: 'label is-error', @state.actionError
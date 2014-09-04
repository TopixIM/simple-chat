
React = require 'react'

$ = React.DOM
$$ = require '../utils/helper'

ProfileEditor = require './profile-editor'

module.exports = React.createClass
  displayName: 'user-panel'

  getInitialState: ->
    editing: no

  viewList: ->
    @props.viewList()

  editUser: ->
    @setState editing: yes

  endEditing: ->
    @setState editing: no

  render: ->
    n = Object.keys(@props.store.teams).length
    avatar = backgroundImage: "url(#{@props.data.avatar})"

    $.div className: 'user-panel',
      $.div className: 'avatar', style: avatar, onClick: @editUser
      $.div className: 'teams button is-fancy', onClick: @viewList, "#{n} teams"

      $$.if @state.editing,
        => ProfileEditor data: @props.data, endEditing: @endEditing
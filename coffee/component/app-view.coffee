
React = require 'react'
$ = React.DOM
$$ = require '../utils/helper'

TeamComponent = require './team-view'
TeamsListComponent = require './teams-list'
UserPanelComponent = require './user-panel'

module.exports = React.createClass
  displayName: 'app-view'

  render: ->
    $.div
      className: 'app-view'
      $$.if @props.data.teamId?,
        => TeamComponent({})
        => TeamsListComponent({})
      UserPanelComponent(data: @props.data.user)

React = require 'react'
$ = React.DOM
$$ = require '../utils/helper'

TeamViewComponent = require './team-view'
TeamsListComponent = require './teams-list'
UserPanelComponent = require './user-panel'
LoginViewComponent = require './login-view'

module.exports = React.createClass
  displayName: 'app-view'

  getInitialState: ->
    isViewingList: yes

  viewList: ->
    @setState isViewingList: yes

  render: ->
    if @props.data.user?
      $.div
        className: 'app-view'
        $$.if @state.isViewingList,
          => TeamsListComponent
            data: @props.data.teams
            currentTeam: @props.data.teamId
          => TeamViewComponent()
        UserPanelComponent
          data: @props.data.user
          store: @props.data
          viewList: @viewList
    else
      LoginViewComponent({})
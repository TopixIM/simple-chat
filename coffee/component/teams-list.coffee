
React = require 'react'

TeamTitleComponent = require './team-title'
TeamDetailComponent = require './team-detail'

$ = React.DOM
$$ = require '../utils/helper'

module.exports = React.createClass
  displayName: 'teams-list'

  getInitialState: ->
    aboutTeam: null
    newTeam: no

  introduceTeam: (data) ->
    @setState aboutTeam: data, newTeam: no

  draftNewTeam: ->
    @setState newTeam: yes

  render: ->
    n = @props.data.length
    current = @props.currentTeam

    $.div className: 'teams-list',
      $.div className: 'header',
        $.div className: 'teams-overview', "There are #{n} teams, current is #{current}."
        $.div className: 'grid-center',
          $.div className: 'button', onClick: @draftNewTeam, 'Create new team'
      $.div className: 'grid-row',
        $.div className: 'titles',
          $.div className: 'header', 'Current teams'
          for key, team of @props.data
            TeamTitleComponent data: team, introduceTeam: @introduceTeam, key: key
        $$.if @state.newTeam,
          => TeamDetailComponent()
          => $$.if @state.aboutTeam?,
            => $.div className: 'team-about',
              'about that team'
            => $.div className: 'grid-center',
              $.span {}, 'No team to preview'
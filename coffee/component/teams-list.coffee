
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

  endEditing: ->
    @setState aboutTeam: null, newTeam: no

  render: ->
    n = Object.keys(@props.data).length

    $.div className: 'teams-list',
      $.div className: 'header',
        $.div className: 'teams-overview', "There are #{n} teams"
        $.div className: 'grid-center',
          $.div className: 'button', onClick: @draftNewTeam, 'Create new team'
      $.div className: 'grid-row',
        $.div className: 'titles',
          $.div className: 'header', 'Current teams'
          for key, team of @props.data
            TeamTitleComponent data: team, introduceTeam: @introduceTeam, key: key
        $$.if @state.newTeam,
          => TeamDetailComponent data: {}, endEditing: @endEditing
          => $$.if @state.aboutTeam?,
            => TeamDetailComponent data: @state.aboutTeam, endEditing: @endEditing
            => $.div className: 'grid-center team-empty',
              $.span {}, 'No team to preview'
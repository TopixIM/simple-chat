
Dispatcher = require './utils/dispatcher'

module.exports = class Store extends Dispatcher
  constructor: ->
    @initData()
    super

  initData: ->
    @data =
      teams: []
      rooms: []
      users: []
      messages: []
      user:
        profile:
          avatar: './images/user.png'
        teamIds: []
      state:
        teamId: undefined
        roomId: undefined
        contactId: undefined

  getData: ->
    @data

  getState: ->
    @data.state

  getUser: ->
    @data.user

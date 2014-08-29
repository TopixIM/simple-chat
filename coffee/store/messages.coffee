
Dispatcher = require '../utils/dispatcher'

class SiteStore extends Dispatcher
  constructor: ->
    @data = []
    super

  get: ->
    @data

module.exports = new SiteStore
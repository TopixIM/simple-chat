
storage = {}
project = 'simple-chat'
try
  localData = JSON.parse localStorage.getItem(project)
  if localData?
    storage = localData

exports.getData = ->
  storage

exports.get = (key) ->
  storage[key]

exports.set = (key, value) ->
  storage[key] = value

window.onbeforeunload = ->
  rawData = JSON.stringify storage
  localStorage.setItem project, rawData
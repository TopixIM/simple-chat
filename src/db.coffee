
fs = require 'fs'

db =
  user: undefined
  teams: {}
  rooms: {}
  users: {}
  messages: {}
backupFile = 'src/backup.json'

try
  do ->
    content = fs.readFileSync backupFile, 'utf8'
    for key, value of (JSON.parse content)
      unless db[key]?
        db[key] = value

backup = ->
  content = JSON.stringify db, null, 2
  fs.writeFileSync backupFile, content

process.on 'exit', backup

exports.find = (name, query, cb) ->
  if db[name]?
    keys = Object.keys query
    results = db[name].filter (record) ->
      for key in keys
        if record[key] isnt query[key]
          return no
      return yes
    cb results
  else
    cb {}

exports.findOne = (name, query, cb) ->
  if db[name]?
    keys = Object.keys query
    for record in db[name]
      matches = yes
      for key in keys
        if record[key] isnt query[key]
          matches = no
          break
      if matches
        cb record
        return
  cb null

exports.get = (name) ->
  db[name]

exports.add = (name, data) ->
  unless db[name]? then db[name] = {}
  db[name][data.id] = data
  backup()

exports.update = (name, data) ->
  unless db[name]? then db[name] = {}
  target = db[name][data.id]
  for key, value of data
    if target[key] isnt value
      target[key] = value
  backup()
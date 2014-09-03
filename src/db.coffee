
fs = require 'fs'

db = {}
backupFile = 'src/backup.json'

try
  content = fs.readFileSync backupFile, 'utf8'
  backup = JSON.parse content
  if backup?
    db = backup

process.on 'exit', ->
  content = JSON.stringify db, null, 2
  fs.writeFileSync backupFile, content

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
    cb []

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

exports.add = (name, data) ->
  unless db[name]?
    db[name] = []
  db[name].push data
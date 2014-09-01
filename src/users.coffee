
data = []

exports.create = (name, password) ->
  data.push {name, password}

exports.get = (name, password) ->
  for item in data
    if (item.name is name) and (item.password is password)
      return item
  return null
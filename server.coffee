
io = require('socket.io').listen 3000
io.set 'log level', 1

io.sockets.on 'connection', (ws) ->

  ws.on 'post', (data) ->
    try
      # console.log 'transfering data', data
      if data.text.length > 1
        data.text = data.text[..60]
        io.sockets.emit 'post', data


dom = require('./dom.coffee')
q = dom.q
ws = require('./ws.coffee').ws

# time functions

new_time = -> (new Date).getTime()
stamp = new_time()
name = localStorage.getItem('name') or 'anonymous' # --!

# watch

monitor = (event) ->
  text = q('#input').value[..60]

  ws.emit 'post', {text, stamp, name}

  if event? and (event.keyCode is 13)
    q('#input').value = ''
    stamp = new_time()

q('#input').focus()
q('#input').oninput = monitor
q('#input').onkeyup = monitor

# name

if name?
  q('#name').value = name
q('#name').onblur = ->
  name = @value
  localStorage.setItem 'name', name

# recive messages

ws.on 'post', (data) -> dom.update data
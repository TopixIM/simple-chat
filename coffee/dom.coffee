
dateformat = require('dateformat')
time = ->
  now = new Date()
  dateformat now, 'mmmm dS, h:MM:ss'

html = require('lilyturf').html

q = exports.q = (query) -> document.querySelector query

exports.update = (data) ->
  if q("#id#{data.stamp}")?
    q("#id#{data.stamp}").querySelector('.text').innerText = data.text
  else
    the_time = time()
    post_html = html ->
      @div class: 'post', id: "id#{data.stamp}",
        @span class: 'name',
          @text data.name
        @span class: 'text',
          @text data.text
        @span class: 'time',
          @text the_time

    q('#list').insertAdjacentHTML 'beforeend', post_html

    children = q('#list').childNodes
    last = children[children.length - 1]
    console.log last
    last.scrollIntoView()
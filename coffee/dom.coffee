
dateformat = require('dateformat')
time = ->
  now = new Date()
  dateformat now, 'mmmm dS, h:MM'

html = require('lilyturf').html

q = exports.q = (query) -> document.querySelector query

# caches

cache_name = ''
cache_time = ''

exports.update = (data) ->
  if q("#id#{data.stamp}")?
    q("#id#{data.stamp}").querySelector('.text').innerText = data.text
    if data.finish?
      q("#id#{data.stamp}").classList.add 'finish'
  else
    the_time = time()
    if the_time is cache_time
      the_time = ''
    else
      cache_time = the_time

    if data.name is cache_name
      the_name = ''
    else
      cache_name = data.name
      the_name = cache_name
      
    post_html = html ->
      @div class: 'post', id: "id#{data.stamp}",
        @span class: 'name',
          @text the_name
        @span class: 'text',
          @text data.text
        @span class: 'time',
          @text the_time

    q('#list').insertAdjacentHTML 'beforeend', post_html

    q("#id#{data.stamp}").scrollIntoView()
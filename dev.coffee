
require('calabash').do 'simple chat',
  'pkill -f doodle'
  'pkill -f server.coffee'
  'jade -o build/ -wP layout/index.jade'
  'watchify -o build/build.js -dt coffeeify coffee/load.coffee -v'
  'doodle build/index.html coffee/ delay:300 server.coffee'
  'node-dev server.coffee'
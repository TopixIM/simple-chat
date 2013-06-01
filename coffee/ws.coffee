
io = require 'socket.io-client'

ws = exports.ws = io.connect 'http://192.168.1.46:3000'
WebSocket = require 'ws'
ws = new WebSocket 'ws://localhost:4001'
# ws = new WebSocket 'ws://198.23.133.167:4001'
# ws = new WebSocket 'ws://ws.bitcointicker.matthisp.com'

ws.on 'message', (data) ->
  date = new Date()
  time = "#{date.getHours()}:#{date.getMinutes()}:#{date.getSeconds()}.#{date.getMilliseconds()}"
  console.log "[#{time}] #{data}"

setInterval () ->
  ws.send 'PING'
, 1000
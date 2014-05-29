WebSocket = require 'ws'
ws = new WebSocket 'ws://localhost:4001'

ws.on 'message', (data) ->
  console.log data
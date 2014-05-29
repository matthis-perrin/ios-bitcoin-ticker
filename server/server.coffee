port = 4001

WebSocketServer = require('ws').Server
wsServer = new WebSocketServer {port: port}

WebSocketManager = require('./WebSocketManager')

console.log 'Server started'
console.log '>> websocket listenning on port ' + port

wsServer.on 'connection', (ws) ->
  WebSocketManager.addWebSocket ws

setInterval () ->
  WebSocketManager.broadcast { data: [1, 2, "3"] }
, 1000
WebSocketManager.start()
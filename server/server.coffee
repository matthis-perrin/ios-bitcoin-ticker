port = 4001

WebSocketServer = require('ws').Server
wsServer = new WebSocketServer {port: port}

WebSocketManager = require('./utils/WebSocketManager')
Buttercoin = require('./exchanges/Buttercoin')

console.log 'Server started'
console.log '>> websocket listenning on port ' + port

Buttercoin.start (data) ->
  WebSocketManager.broadcast data

wsServer.on 'connection', (ws) ->
  WebSocketManager.addWebSocket ws

WebSocketManager.start()
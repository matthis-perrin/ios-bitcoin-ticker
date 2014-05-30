port = 4001

WebSocketServer = require('ws').Server
wsServer = new WebSocketServer {port: port}

WebSocketManager = require('./utils/WebSocketManager')
ExchangeManager = require('./utils/ExchangeManager')
Buttercoin = require('./exchanges/Buttercoin')

console.log 'Server started'
console.log '>> websocket listenning on port ' + port

WebSocketManager.init ExchangeManager
ExchangeManager.init WebSocketManager
WebSocketManager.start()

Buttercoin.start (data) ->
  ExchangeManager.exchangeEvent data.exchange, data.data

wsServer.on 'connection', (ws) ->
  WebSocketManager.addWebSocket ws

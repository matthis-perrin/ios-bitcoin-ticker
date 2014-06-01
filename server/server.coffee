argv = require('minimist')(process.argv.slice(2))

host = argv.h or '0.0.0.0'
port = argv.p or 4001

WebSocketServer = require('ws').Server
wsServer = new WebSocketServer
  host: host
  port: port

WebSocketManager = require('./utils/WebSocketManager')
ExchangeManager = require('./utils/ExchangeManager')
Buttercoin = require('./exchanges/Buttercoin')
Bitstamp = require('./exchanges/Bitstamp')
Coinbase = require('./exchanges/Coinbase')

console.log 'Server started'
console.log '>> websocket listenning on port ' + port

WebSocketManager.init ExchangeManager
ExchangeManager.init WebSocketManager
WebSocketManager.start()

exchangeCallback = (exchange, data) ->
  ExchangeManager.exchangeEvent exchange, data

Buttercoin.start exchangeCallback
Bitstamp.start exchangeCallback
Coinbase.start exchangeCallback

wsServer.on 'connection', (ws) ->
  WebSocketManager.addWebSocket ws

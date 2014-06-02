argv = require('minimist')(process.argv.slice(2))

host = argv.h or '0.0.0.0'
port = argv.p or 4001

WebSocketServer = require('ws').Server
wsServer = new WebSocketServer
  host: host
  port: port

Logger =           require './utils/Logger'
WebSocketManager = require './utils/WebSocketManager'
ExchangeManager =  require './utils/ExchangeManager'
Buttercoin =       require './exchanges/Buttercoin'
Bitstamp =         require './exchanges/Bitstamp'
Coinbase =         require './exchanges/Coinbase'

Logger.info 'Starting server on port ' + port + '.'

WebSocketManager.init ExchangeManager
ExchangeManager.init WebSocketManager
WebSocketManager.start()

exchanges = [Buttercoin, Bitstamp, Coinbase]
for exchange in exchanges
  ExchangeManager.addExchangeMetaData exchange.start (exchange, data) ->
    ExchangeManager.exchangeEvent exchange, data

Logger.info 'Server started. Waiting for connections.'

wsServer.on 'connection', (ws) ->
  WebSocketManager.addWebSocket ws


process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0'
WebSocket = require 'ws'

class Buttercoin

  NAME = 'BUTTERCOIN'
  INTERVAL = 10000
  CURRENCY = 'BTC'

  cb = null
  ws = null
  wsLoop = null
  getTickerMessage = "{\"query\":\"TICKER\",\"currencies\":[\"USD\",\"BTC\"]}"

  lastBid = null
  lastAsk = null


  @start = (callback) ->
    cb = callback
    restartWebSocket()


  restartWebSocket = ->
    ws.close() if ws?
    clearInterval wsLoop if wsLoop?

    ws = new WebSocket 'wss://api.buttercoin.com/api/v1/websocket', { protocolVersion: 13, origin: 'https://www.buttercoin.com' }

    ws.on 'message', (data) ->
      handleMessage data

    ws.on 'open', () ->
      sendMessage getTickerMessage
      wsLoop = setInterval () ->
        sendMessage getTickerMessage
      , INTERVAL

    sendMessage = (message) ->
        try
          ws.send message, (err) ->
            restartWebSocket() if err?
        catch
          restartWebSocket()

    handleMessage = (data) ->
      data = JSON.parse(data)
      if data.result is 'TICKER'
        result = {
          exchange: NAME
          data:
            bid: data.bid.amount
            ask: data.ask.amount
            time: new Date().getTime()
        }
        if result.data.bid != lastBid || result.data.ask != lastAsk
          lastBid = result.data.bid
          lastAsk = result.data.ask
          cb result


module.exports = Buttercoin
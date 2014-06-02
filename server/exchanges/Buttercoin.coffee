Logger = require '../utils/Logger'
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0'
WebSocket = require 'ws'

class Buttercoin

  NAME = 'BUTTERCOIN'
  CURRENCY = 'BTC'
  INTERVAL = 10000

  cb = null
  ws = null
  wsLoop = null
  getTickerMessage = "{\"query\":\"TICKER\",\"currencies\":[\"USD\",\"BTC\"]}"

  lastBid = null
  lastAsk = null


  @start = (callback) ->
    cb = callback
    restartWebSocket()
    return {
      name: NAME
      image: 'http://static.bitcointicker.matthisp.com/buttercoin.png'
    }


  restartWebSocket = ->
    try
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

      ws.on 'close', () ->
        Logger.error 'Buttercoin websocket closed'
        restartWebSocket()

      ws.on 'error', (err) ->
        Logger.error 'Buttercoin error\n' + err
        restartWebSocket()
    catch err
      Logger.error 'Buttercoin error\n' + err
      restartWebSocket()



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
          bid: parseFloat(data.bid.amount)
          ask: parseFloat(data.ask.amount)
          time: new Date().getTime()
      }
      if result.data.bid isnt lastBid || result.data.ask isnt lastAsk
        lastBid = result.data.bid
        lastAsk = result.data.ask
        cb NAME, {bid: lastBid, ask: lastAsk, time: new Date().getTime()}


module.exports = Buttercoin
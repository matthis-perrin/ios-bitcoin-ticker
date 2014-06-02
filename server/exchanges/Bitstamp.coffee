Pusher = require 'pusher-client'
Logger = require '../utils/Logger'


class Bitstamp

  NAME = 'BITSTAMP'
  CURRENCY = 'BTC'

  cb = null
  lastBid = null
  lastAsk = null


  @start = (callback) ->
    try
      cb = callback
      socket = new Pusher('de504dc5763aeef9ff52')
      channel = socket.subscribe('order_book')
      channel.bind 'data', (data) ->
        bid = parseFloat(data.bids[0][0])
        ask = parseFloat(data.asks[0][0])
        if bid isnt lastBid or ask isnt lastAsk
          lastBid = bid
          lastAsk = ask
          cb NAME, {bid: lastBid, ask: lastAsk}
      return {
        name: NAME
        image: 'http://static.bitcointicker.matthisp.com/bitstamp.png'
      }
    catch err
      Logger.error 'Bitstamp error\n' + err
      return @start callback

module.exports = Bitstamp
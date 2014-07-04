https = require 'https'
Logger = require '../utils/Logger'


class Buttercoin

  NAME = 'BUTTERCOIN'
  CURRENCY = 'BTC'
  INTERVAL = 5000

  cb = null
  lastBid = null
  lastAsk = null


  @start = (callback) ->
    cb = callback
    grabPrice()
    setInterval grabPrice, INTERVAL
    return {
      name: NAME,
      metadata: {
        image: 'http://static.bitcointicker.matthisp.com/buttercoin.png'
      }
    }

  grabPrice = ->
    try
      https.get 'https://api.buttercoin.com/v1/ticker', (res) ->
        data = ''
        res.on 'data', (chunk) ->
          data += chunk
        res.on 'end', () ->
          try
            data = JSON.parse(data)
            bid = if data.bid then parseFloat(data.bid) else null
            ask = if data.ask then parseFloat(data.ask) else null
            if (bid? and bid isnt lastBid) or (ask? and ask isnt lastAsk)
              lastBid = bid if bid?
              lastAsk = ask if ask?
              cb NAME, {bid: lastBid, ask: lastAsk, time: new Date().getTime()}
          catch err
            Logger.error 'Buttercoin error\n' + err
      .on 'error', (err) ->
        Logger.error 'Buttercoin error\n' + err
    catch err
      Logger.error 'Buttercoin error\n' + err


module.exports = Buttercoin
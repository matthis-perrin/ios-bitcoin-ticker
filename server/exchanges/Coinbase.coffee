https = require 'https'
Logger = require '../utils/Logger'


class Coinbase

  NAME = 'COINBASE'
  CURRENCY = 'BTC'
  INTERVAL = 10000

  cb = null
  lastBid = null
  lastAsk = null


  @start = (callback) ->
    cb = callback
    startGrabber 'buy', 'bid'
    startGrabber 'sell', 'ask'
    return {
      name: NAME,
      metadata: {
        image: 'http://static.bitcointicker.matthisp.com/coinbase.png'
      }
    }

  startGrabber = (type, property) ->
    grabPrice type, property
    setInterval () ->
      grabPrice type, property
    , INTERVAL

  grabPrice = (type, property) ->
    try
      https.get 'https://coinbase.com/api/v1/prices/' + type, (res) ->
        data = ''
        res.on 'data', (chunk) ->
          data += chunk
        res.on 'end', () ->
          try
            value = JSON.parse(data).subtotal.amount
            bid = if property is 'bid' then parseFloat(value) else null
            ask = if property is 'ask' then parseFloat(value) else null
            if (bid? and bid isnt lastBid) or (ask? and ask isnt lastAsk)
              lastBid = bid if bid?
              lastAsk = ask if ask?
              cb NAME, {bid: lastBid, ask: lastAsk, time: new Date().getTime()}
          catch err
            Logger.error 'Coinbase error\n' + err
      .on 'error', (err) ->
        Logger.error 'Coinbase error\n' + err
    catch err
      Logger.error 'Coinbase error\n' + err


module.exports = Coinbase
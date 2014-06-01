https = require('https')


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
    metadata = {}
    metadata[NAME] = {
      image: 'http://static.bitcointicker.matthisp.com/coinbase.png'
    }
    return metadata

  startGrabber = (type, property) ->
    grabPrice type, property
    setInterval () ->
      grabPrice type, property
    , INTERVAL

  grabPrice = (type, property) ->
    https.get 'https://coinbase.com/api/v1/prices/' + type, (res) ->
      data = ''
      res.on 'data', (chunk) ->
        data += chunk
      res.on 'end', () ->
        value = JSON.parse(data).subtotal.amount
        bid = if property is 'bid' then parseFloat(value) else null
        ask = if property is 'ask' then parseFloat(value) else null
        if (bid? and bid isnt lastBid) or (ask? and ask isnt lastAsk)
          lastBid = bid if bid?
          lastAsk = ask if ask?
          cb NAME, {bid: lastBid, ask: lastAsk}
    .on 'error', -> console.log 'Coinbase error'


module.exports = Coinbase
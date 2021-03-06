Logger = require './Logger'

class ExchangeManager

  @data = {}
  @metadata = {}
  

  wsManager = null


  @init = (manager) ->
    wsManager = manager


  @exchangeEvent = (exchangeName, data) ->
    @data[exchangeName] = data
    toSend = {
      type: 'PRICE'
      data: {}
    }
    toSend.data[exchangeName] = data
    wsManager.broadcast toSend


  counter = 0
  @addExchangeMetaData = (exchangeName, metadata) ->
    Logger.info exchangeName + ' exchange started.'
    metadata.index = counter++
    @metadata[exchangeName] = metadata


module.exports = ExchangeManager
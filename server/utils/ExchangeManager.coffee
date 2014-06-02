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


  @addExchangeMetaData = (exchangeName, metadata) ->
    Logger.info exchangeName + ' exchange started.'
    @metadata[exchangeName] = metadata


module.exports = ExchangeManager
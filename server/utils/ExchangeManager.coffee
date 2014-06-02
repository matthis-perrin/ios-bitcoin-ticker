Logger = require './Logger'

class ExchangeManager

  @data = {}
  @metadata = []
  

  wsManager = null


  @init = (manager) ->
    wsManager = manager


  @exchangeEvent = (exchangeName, data) ->
    @data[exchangeName] = data
    toSend = {}
    toSend[exchangeName] = @data[exchangeName]
    wsManager.broadcast toSend


  @addExchangeMetaData = (metadata) ->
    Logger.info metadata.name + ' exchange started.'
    @metadata.push metadata


module.exports = ExchangeManager
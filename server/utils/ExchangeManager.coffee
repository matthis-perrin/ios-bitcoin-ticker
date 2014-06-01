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


  @addExchangeMetaData = (metadata) -> @metadata.push metadata


module.exports = ExchangeManager
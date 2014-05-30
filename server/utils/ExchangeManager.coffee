class ExchangeManager

  @data = {}
  

  wsManager = null


  @init = (manager) ->
    wsManager = manager


  @exchangeEvent = (exchangeName, values) ->
    @data[exchangeName] = values
    toSend = {}
    toSend[exchangeName] = values
    wsManager.broadcast toSend


module.exports = ExchangeManager
class ExchangeManager

  @data = {}
  

  wsManager = null


  @init = (manager) ->
    wsManager = manager


  @exchangeEvent = (exchangeName, data) ->
    @data[exchangeName] = data
    toSend = {}
    toSend[exchangeName] = @data[exchangeName]
    wsManager.broadcast toSend


module.exports = ExchangeManager
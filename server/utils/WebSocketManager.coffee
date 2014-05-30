class WebSocketManager

  # Internal property
  webSocketList = []
  pingLoopInterval = null
  exchangeManager = null


  # Public methods
  @init = (exchManager) ->
    exchangeManager = exchManager


  @addWebSocket = (ws) ->
    webSocketList.push ws
    sendWelcomeMessage ws
    ws.on 'close', => @removeWebSocket ws

  @removeWebSocket = (ws) ->
    index = webSocketList.indexOf ws
    if index isnt -1
      webSocketList[index].close()
      webSocketList.splice index, 1

  @broadcast = (data) ->
    for ws in webSocketList
      send ws, JSON.stringify data

  @start = () ->
    clearInterval pingLoopInterval if pingLoopInterval?
    pingLoopInterval = setInterval @broadcast, 30000, "PING"


  # Internal methods
  send = (ws, message) ->
    try
      ws.send message, (err) ->
        @removeWebSocket ws if err
    catch e
      @removeWebSocket ws

  sendWelcomeMessage = (ws) ->
    send ws, JSON.stringify exchangeManager.data if exchangeManager



module.exports = WebSocketManager
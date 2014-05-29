class WebSocketManager

  # Internal property
  webSocketList = []


  # Public methods
  @addWebSocket = (ws) ->
    webSocketList.push ws
    ws.on 'close', => @removeWebSocket ws
    sendWelcomeMessage ws

  @removeWebSocket = (ws) ->
    index = webSocketList.indexOf ws
    webSocketList.splice index, 1 if index isnt -1

  @broadcast = (data) ->
    for ws in webSocketList
      send ws, JSON.stringify data


  # Internal methods
  send = (ws, message) ->
    try
      ws.send message, (err) ->
        @removeWebSocket ws if err
    catch e
      @removeWebSocket ws

  sendWelcomeMessage = (ws) ->
    send ws, 'Hello'



module.exports = WebSocketManager
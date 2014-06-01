WebSocket = require 'ws'


wsToOpen =    if process.argv[2]? then process.argv[2] else 100
wsPerSecond = if process.argv[3]? then process.argv[3] else 10
wsOpened = 0
wsError = 0
messageReceived = 0


logInfo = () ->
  process.stdout.clearLine()
  process.stdout.cursorTo(0)
  process.stdout.write wsOpened + ' websockets opened (' + wsError + ' error(s)), ' + messageReceived + ' messages received'

openWebSockets = () ->
  if wsOpened < wsToOpen
    try
      # ws = new WebSocket 'ws://localhost:4001'
      ws = new WebSocket 'ws://198.23.133.167:4001/'
      ws.on 'error', -> wsError++
      ws.on 'message', -> messageReceived++
      wsOpened++
      setTimeout openWebSockets, 1000 / wsPerSecond
    catch
      setTimeout openWebSockets, 1000 / wsPerSecond


console.log '>> Start stress testing client'
console.log '>> Opening ' + wsToOpen + ' websockets at the rate ' + wsPerSecond + '/sec'
logInfo()
openWebSockets()
setInterval logInfo, 200
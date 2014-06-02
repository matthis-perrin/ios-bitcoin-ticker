class Logger

  @error = (message) -> @log 'ERROR' , message
  @info = (message) -> @log 'INFO' , message
  @debug = (message) -> @log 'DEBUG' , message

  @log = (type, message) ->
    console.log '[' + type + '] ' + message

module.exports = Logger
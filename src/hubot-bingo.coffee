_ = require('lodash')
util = require('util')

rules = require('./bullshit')
Bingo = require('./bingo')

class HubotBingoAdapter
  constructor: (@robot) ->
    @bingo = new Bingo(rules)
    @robot.hear(/.*/i, @handleMessage)

  formatReply: (buzzwords, name) ->
    "#{name.toUpperCase()} BINGO! (#{buzzwords.join(', ')})"

  handleMessage: (res) =>
    wonBingos = @bingo.play(res.message.text)
    if wonBingos
      bingoMessages = _.map(wonBingos, @formatReply)
      res.send(bingoMessages.join('\n'))

module.exports = (robot) -> new HubotBingoAdapter(robot)

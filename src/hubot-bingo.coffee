_ = require('lodash')
util = require('util')

rules = require('./bullshit')
Bingo = require('./bingo')

class HubotBingoAdapter
  constructor: (@robot) ->
    @userBingos = {}
    @robot.hear(/.*/i, @handleMessage)

  formatReply: (buzzwords, name) ->
    "#{name.toUpperCase()} BINGO! (#{buzzwords.join(', ')})"

  handleMessage: (res) =>
    user = res.message.user
    bingo = @userBingos[user.id] = @userBingos[user.id] or new Bingo(rules)
    wonBingos = bingo.play(res.message.text)

    if not _.isEmpty(wonBingos)
      bingoMessages = _.map(wonBingos, @formatReply)
      res.send("@#{user.name}: #{bingoMessages.join('\n')}")

module.exports = (robot) -> new HubotBingoAdapter(robot)

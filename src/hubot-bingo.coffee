_ = require('lodash')
util = require('util')

rules = require('./bullshit')
Bingo = require('./bingo')

class HubotBingoAdapter
  constructor: (@robot) ->
    @userBingos = {}
    @robot.respond(/scores/i, @showScores)
    @robot.hear(/.*/i, @handleMessage)

  getUsername: (userId) ->
    @robot.brain.userForId(userId).name

  toUserScores: (bingo, user) =>
    _.extend(bingo.getScores(), name: @getUsername(user))

  getUserScores: ->
    scores = _.map(@userBingos, @toUserScores)
    _.sortBy(scores, _.method('totalScores'))

  formatUserScores: (scores) ->
    currentMatches = scores.currentMatches()
    currentScores = if not _.isEmpty(currentMatches) then "| currently: [#{currentMatches.join(', ')}]" else ''
    "#{scores.name}: #{scores.wins} bingos #{currentScores}"

  showScores: (res) =>
    scores = @getUserScores()
    res.send("Scores:\n #{scores.map(@formatUserScores).join('\n')}")

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

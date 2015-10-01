_ = require('lodash')

Ruleset = require('./ruleset')
Scores = require('./scores')

class Bingo
  constructor: (rules) ->
    @rules = _.mapValues(rules, (data) -> new Ruleset(data))
    @bullshit = {}
    @wins = 0

  matchAllRules: (message) ->
    matches = _.mapValues(@rules, (ruleset) -> ruleset.getMatchedBuzzwords(message))
    @bullshit = _.extend(@bullshit, matches, _.union)

  checkCombo: (buzzwords, name) =>
    @rules[name].isBingo(buzzwords)

  getWinningCombos: ->
    wonCombos = _.pick(@bullshit, @checkCombo)
    @bullshit = _.omit(@bullshit, @checkCombo)
    @wins++ if not _.isEmpty(wonCombos)
    wonCombos

  toScores: (result, buzzwords, name) =>
    if not _.isEmpty(buzzwords)
      result[name] =
        currentMatches: buzzwords.length
        requiredMatches: @rules[name].requiredMatches

  play: (message) ->
    @matchAllRules(message)
    @getWinningCombos()

  getScores: ->
    scores = _.transform(@bullshit, @toScores, {})
    new Scores(@wins, scores)

module.exports = Bingo

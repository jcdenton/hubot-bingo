_ = require('lodash')

Ruleset = require('./ruleset')

class Bingo
  constructor: (rules) ->
    @rules = _.mapValues(rules, (data) -> new Ruleset(data))
    @bullshit = {}

  matchAllRules: (message) ->
    matches = _.mapValues(@rules, (ruleset) -> ruleset.getMatchedBuzzwords(message))
    @bullshit = _.extend(@bullshit, matches, _.union)

  checkCombo: (buzzwords, name) =>
    @rules[name].isBingo(buzzwords)

  getWinningCombos: ->
    wonCombos = _.pick(@bullshit, @checkCombo)
    @bullshit = _.omit(@bullshit, @checkCombo)
    wonCombos

  play: (message) ->
    @matchAllRules(message)
    @getWinningCombos()

module.exports = Bingo

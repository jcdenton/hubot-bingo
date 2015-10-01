_ = require('lodash')

class Scores
  constructor: (@wins, @scores) ->

  totalScores: ->
    _.map(@scores, _.property 'currentMatches').reduce(_.add, @wins)

  currentMatches: ->
    _.map(@scores, (value, buzzword) -> "#{buzzword}: #{value.currentMatches}/#{value.requiredMatches}")

module.exports = Scores

_ = require('lodash')

String::matchesAnyOf = (patterns) ->
  _.find(patterns, (pattern) => @search(pattern) > -1)?

class Ruleset
  constructor: (data) ->
    @requiredMatches = data.requiredMatches
    @patterns = _.mapValues data.buzzwords, (patterns) ->
      patterns.map (pattern) -> new RegExp(pattern, 'gim')

  getMatchedBuzzwords: (message) ->
    (buzzword for buzzword, patterns of @patterns when message.matchesAnyOf(patterns))

  isBingo: (buzzwords) ->
    _.intersection(buzzwords, _.keys(@patterns))?.length >= @requiredMatches

module.exports = Ruleset

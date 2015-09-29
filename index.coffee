fs = require 'fs'
path = require 'path'

scripts = ['hubot-bingo.coffee']

module.exports = (robot) ->
  scriptsPath = path.resolve(__dirname, 'src')
  for script in scripts
    robot.loadFile(scriptsPath, script)
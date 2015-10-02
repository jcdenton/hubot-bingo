'use strict'
chai = require('chai')
sinon = require('sinon')
sinonChai = require('sinon-chai')
expect = chai.expect
chai.use(sinonChai)

describe 'bingo', ->
  beforeEach ->
    @robot =
      hear: sinon.spy()
      respond: sinon.spy()

  it 'registers a hear listener', ->
    require('../src/hubot-bingo')(@robot)
    expect(@robot.hear).to.be.calledWith(/.*/i)

  it 'registers a respond listener', ->
    require('../src/hubot-bingo')(@robot)
    expect(@robot.respond).to.be.calledWith(/scores/i)

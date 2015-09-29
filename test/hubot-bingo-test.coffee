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

  it 'registers a hear listener', ->
    require('../src/hubot-bingo')(@robot)
    expect(@robot.hear).to.be.calledWith(/.*/i)

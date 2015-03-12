K = require 'kefir'
{Left, Right} = require 'fantasy-eithers'
{Some, None} = require 'fantasy-options'
{attempt, fromEither, fromOption} = require '../src/fantasy'

describe "attempt", ->
  it "should emit values on the right and errors on the left", ->
    r = []
    s = attempt(K.concat([K.constant(1), K.constantError("E1"), K.constant(2)]))
    s.onValue((v) -> r.push(v))
    expect(r).to.deep.equal([Right(1), Left("E1"), Right(2)])

describe "fromEither", ->
  it "should emit Left as error", ->
    l = {type: 'error', current: true, value: "E"}
    res = []
    fromEither(Left("E")).onAny((e) -> res.push(e))
    expect(res[0]).to.deep.equal(l)

  it "should emit Right as value", ->
    r = {type: 'value', current: true, value: "V"}
    res = []
    fromEither(Right("V")).onAny((v) -> res.push(v))
    expect(res[0]).to.deep.equal(r)

describe "fromOption", ->
  it "should never emit for None", ->
    n = {type: 'end', current: true, value: undefined}
    res = []
    fromOption(None).onAny((v) -> res.push(v))
    expect(res[0]).to.deep.equal(n)

  it "should emit Some as a value", ->
    s = {type: 'value', current: true, value: 'X'}
    res = []
    fromOption(Some('X')).onAny((x) -> res.push(x))
    expect(res[0]).to.deep.equal(s)


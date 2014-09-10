# Module
cyclone = require '../lib'

# Dependencies
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
chai = require 'chai'
{expect} = chai
chai.use(sinonChai)

o = it
x = it.skip

describe 'cyclone', ->
  describe '.clone', ->
    context 'when given an object', ->
      beforeEach ->
        @obj =
          foo: 'foo'
          bar: true
          baz: 10

      o 'Should shallowy clone the object', ->
        clone = cyclone.clone(@obj)
        expect(clone).to.not.equal @obj
        expect(clone).to.eql(@obj)

    context 'when given an array', ->
      beforeEach ->
        @array = [1, 2, 3]

      o 'Should shallowy clone the array', ->
        clone = cyclone.clone(@array)
        expect(clone).to.not.equal @array
        expect(clone).to.eql(@array)

  describe '.cloneDeep', ->
    context 'when given an object', ->
      beforeEach ->
        @deepObj = bar: true
        @obj = foo: @deepObj

      o 'Should deeply clone object', ->
        clone = cyclone.cloneDeep(@obj)
        expect(clone).to.not.equal @obj
        expect(clone).to.eql @obj
        expect(clone.foo).to.not.equal @deepObj

    context 'when given an object cyclic references', ->
      beforeEach ->
        nested = biz: true
        @obj = bar: baz: nested
        @obj.foo = @obj

      o 'Should deeply clone object', ->
        clone = cyclone.cloneDeep(@obj)
        expect(clone).to.not.equal @obj
        expect(clone).to.eql @obj
        expect(clone.foo).to.equal clone

    context 'when given an array', ->
      beforeEach ->
        @nested = [4, 5, 6]
        @array = [1, 2, @nested]

      o 'Should deeply clone array', ->
        clone = cyclone.cloneDeep(@array)
        expect(clone).to.not.equal(@array)
        expect(clone).to.eql(@array)
        expect(clone[2]).to.not.equal @nested
        expect(clone[2]).to.eql @nested


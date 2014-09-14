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
        clone = cyclone.clone @obj
        expect(clone).to.not.equal @obj
        expect(clone).to.eql @obj

    context 'when given an array', ->
      beforeEach ->
        @array = [1, 2, 3]

      o 'Should shallowy clone the array', ->
        clone = cyclone.clone @array
        expect(clone).to.not.equal @array
        expect(clone).to.eql @array

  describe '.cloneDeep', ->
    context 'when given an object', ->
      beforeEach ->
        @deepObj = bar: true
        @obj = foo: @deepObj

      o 'Should deeply clone object', ->
        clone = cyclone.cloneDeep @obj
        expect(clone).to.not.equal @obj
        expect(clone).to.eql @obj
        expect(clone.foo).to.not.equal @deepObj

    context 'when given an object with a prototype', ->
      beforeEach ->
        Person = (opts) ->
          this.name = opts.name
        Person.prototype =
          foo: 'foo'

        @obj = (new Person name: 'sean')

      o 'Should deeply clone the instance', ->
        clone = cyclone.cloneDeep @obj
        expect(clone).to.not.equal @obj
        expect(clone).to.eql @obj
        expect(clone.__proto__).to.equal @obj.__proto__

    context 'when given an object cyclic references', ->
      beforeEach ->
        nested = biz: true
        @obj = bar: baz: nested
        @obj.foo = @obj

      o 'Should deeply clone object', ->
        clone = cyclone.cloneDeep @obj
        expect(clone).to.not.equal @obj
        expect(clone).to.eql @obj
        expect(clone.foo).to.equal clone

    context 'when given an array', ->
      beforeEach ->
        @nested = [4, 5, 6]
        @array = [1, 2, @nested]

      o 'Should deeply clone array', ->
        clone = cyclone.cloneDeep @array
        expect(clone).to.not.equal @array
        expect(clone).to.eql @array
        expect(clone[2]).to.not.equal @nested
        expect(clone[2]).to.eql @nested

    context 'when given a sparse array', ->
      beforeEach ->
        @array = ['', '', '', 1, '']

      o 'Should deeply clone array', ->
        clone = cyclone.cloneDeep @array
        expect(clone).to.not.equal @array
        expect(clone).to.eql @array
        expect(clone.length).to.equal @array.length

    context 'when given a boolean primative', ->
      o 'Should clone the primative', ->
        clone = cyclone.cloneDeep true
        expect(clone).to.equal true

    context 'when given a boolean object', ->
      o 'Should deeply clone the boolean object to a primative', ->
        clone = cyclone.cloneDeep (new Boolean false)
        expect(clone).to.equal false

    context 'when given a number primative', ->
      o 'Should clone the primative', ->
        clone = cyclone.cloneDeep 1
        expect(clone).to.equal 1

    context 'when given a number object', ->
      o 'Should deeply clone the number object to a primative', ->
        clone = cyclone.cloneDeep (new Number 2)
        expect(clone).to.equal 2

    context 'when given a string primative', ->
      o 'Should clone the primative', ->
        clone = cyclone.cloneDeep 'foo'
        expect(clone).to.equal 'foo'

    context 'when given a string object', ->
      o 'Should deeply clone the string object to a primative', ->
        clone = cyclone.cloneDeep (new String 'bar')
        expect(clone).to.equal 'bar'

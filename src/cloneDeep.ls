cloneDeepRouter = require './cloneDeepRouter'
Map = require './map'

cloneDeep = (value) ->
  traversedMap = Map()
  clone = cloneDeepRouter value, traversedMap
  delete! traversedMap
  clone

module.exports = cloneDeep

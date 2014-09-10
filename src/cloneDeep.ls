map = require './map'

initCloning = (obj, clone, traversedMap) ->
  for own let key, val of obj
    clone[key] = cloneDeep val, traversedMap

cloneDeepObject = (obj, traversedMap) ->
  if selfReference = traversedMap.get(obj)
    return selfReference

  clone = {}
  traversedMap.set(obj, clone)
  initCloning(obj, clone, traversedMap)
  clone

cloneDeep = (value, traversedMap = map()) ->
  if typeof value is 'object'
    cloneDeepObject value, traversedMap
  else
    value

module.exports = cloneDeep

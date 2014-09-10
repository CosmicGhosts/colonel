cloneDeepObject = (obj, traversedMap, cloneDeepRouter) ->
  if selfReference = traversedMap.get(obj)
    return selfReference

  clone = {}
  traversedMap.set(obj, clone)
  for own let key, val of obj
    clone[key] = cloneDeepRouter val, traversedMap
  clone

module.exports = cloneDeepObject

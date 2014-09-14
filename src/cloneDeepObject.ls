cloneDeepObject = (obj, traversedMap, cloneDeepRouter) ->
  if selfReference = traversedMap.get(obj) then return selfReference
  proto = Object.getPrototypeOf obj
  clone = Object.create(proto)
  traversedMap.set(obj, clone)

  for own let key, val of obj
    clone[key] = cloneDeepRouter val, traversedMap
  clone

module.exports = cloneDeepObject

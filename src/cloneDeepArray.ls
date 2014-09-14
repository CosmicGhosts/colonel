cloneDeepArray = (value, traversedMap, cloneDeepRouter) ->
  clone = (new Array value.length)
  traversedMap.set value, clone
  for let elem, index in value
    clone[index] = cloneDeepRouter elem, traversedMap
  clone

module.exports = cloneDeepArray

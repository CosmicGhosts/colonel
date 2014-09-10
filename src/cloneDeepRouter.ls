map = require './map'
cloneDeepObject = require './cloneDeepObject'
cloneDeepArray = require './cloneDeepArray'

cloneDeepRouter = (value, traversedMap = map()) ->
  if Array.isArray(value)
    clonedDeepArray value, traversedMap, cloneDeepRouter
  else if typeof value is 'object'
    cloneDeepObject value, traversedMap, cloneDeepRouter
  else
    value

module.exports = cloneDeepRouter

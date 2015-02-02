cloneDeepObject = require './cloneDeepObject'
cloneDeepArray = require './cloneDeepArray'

cloneDeepDefault = (value) ->
  type = global[value.constructor.name]
  (new type value.valueOf!).valueOf!

toString = (value) ->
  Object.prototype.toString.call(value)

methods =
  '[object Array]': cloneDeepArray
  '[object Object]': cloneDeepObject
  '[object Boolean]': cloneDeepDefault
  '[object Number]': cloneDeepDefault
  '[object String]': cloneDeepDefault

cloneDeepRouter = (value, traversedMap) ->
  type = toString value
  method = methods[type]
  if method
    method value, traversedMap, cloneDeepRouter
  else
    value

module.exports = cloneDeepRouter

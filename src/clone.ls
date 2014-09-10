cloneObject = (obj) ->
  clone = {}
  for own let key, value of obj
    clone[key] = value
  clone

cloneArray = (array) ->
  array.map (item) -> item

cloneRouter = (value) ->
  if Array.isArray value
    cloneArray value
  else
    cloneObject value

clone = (value) ->
  cloneRouter(value)

module.exports = clone

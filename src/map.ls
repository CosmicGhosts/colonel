map = ->
  traversed = []
  cloned = []

  set: (value, value2) ->
    traversed.push(value)
    cloned.push(value2)

  get: (value) ->
    length = traversed.length
    while length--
      if traversed[length] is value
        return cloned[length]

module.exports = map

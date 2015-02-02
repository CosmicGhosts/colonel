class Map
  ->
    @traversed = []
    @cloned = []

  set: (key, value) ->
    @traversed.push(key)
    @cloned.push(value)

  get: (value) ->
    index = @traversed.indexOf(value)
    @cloned[index]

module.exports = Map

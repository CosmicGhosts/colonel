module.exports = ->
  if(!Map) then Map = require('./map.polyfill')
  map = new Map()

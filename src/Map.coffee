react = require "react/addons"
leaflet = require "leaflet"

Type = react.PropTypes
latlngType = require "./types/latlng"
latlngListType = require "./types/latlngList"

eventsMixins = require "./mixins/events"

{div} = react.DOM
currentId = 0

Map = react.createClass
  displayName: "Map"

  mixins: [eventsMixins "map"]

  statics:
    uid: -> "map#{ ++currentId }"

  propTypes:
    center: latlngType
    zoom: Type.number
    minZoom: Type.number
    maxZoom: Type.number
    maxBounds: latlngListType

  getInitialState: ->
    id: Map.uid()

  componentDidMount: ->
    map = leaflet.map @state.id, @props
    @bindEvents @state._events
    @setState {map}

  render: ->
    if @state.map? then children = react.Children.map @props.children, (child) =>
      react.addons.cloneWithProps child, map: @state.map
    div id: @state.id, children

module.exports = Map

class_name Tile
extends Node2D

enum TerrainType {
	Basic,
	Water,
	Mountain
}

@export var map: Map

@onready var shape: RegularPolygon = $Shape
@onready var tooltip: RichTextLabel:
	get:
		return $Tooltip

@onready var size: float:
	get:
		return shape.size
	set(value):
		shape.size = value

@onready var type: TerrainType:
	set(value):

		type = value

		match type:
			TerrainType.Basic:
				modulate = Color.LIGHT_GREEN
			TerrainType.Water:
				modulate = Color.LIGHT_BLUE
			TerrainType.Mountain:
				modulate = Color.ROSY_BROWN

var coordinates: Map.Coordinates:
	set(value):
		coordinates = value

		$Debug/Q.text = str(coordinates.q)
		$Debug/R.text = str(coordinates.r)
		$Debug/S.text = str(coordinates.s)

var placementBonus: PlacementBonus:
	set(value):
		if (value == placementBonus):
			return
		placementBonus = value
		tooltip.text = placementBonus.rules.rules_text()
		if tooltip.text.length() > 0:
			$PlacementBonus.visible = true
var structure: Structure

func get_neighbours() -> Array[Tile]:
	var neighbours: Array[Tile] = []

	for vec in Utils.get_axial_neighbors(coordinates.to_vec()):
		var n = map.get_tile(Map.Coordinates.new(vec.x, vec.y))

		if (n != null):
			neighbours.push_back(n)

	return neighbours

func _ready() -> void:
	assert(map != null)
	scale = Vector2.ONE * .2
	create_tween().tween_property(self, 'scale', Vector2.ONE, .2)
	shape.clicked.connect(_on_tile_pressed)
	shape.hovered.connect(_on_tile_hovered)
	Debug.toggled.connect(func(on): $Debug.visible=on)

func _on_tile_pressed() -> void:
	Events.tileClicked.emit(self)
func _on_tile_hovered(state: bool) -> void:
	if (state):
		Events.tileHovered.emit(self)
	
	if tooltip.text.length() > 0:
		tooltip.visible = state
	else:
		tooltip.visible = false
	$Debug/Hovered.visible = state

class_name Tile
extends Node2D

signal onHovered(tile: Tile)
signal onClicked(tile: Tile)

var map: Map

@onready var shape: RegularPolygon:
	get:
		return $Shape
@onready var tooltip: RichTextLabel:
	get:
		return $Tooltip
@onready var icon: Sprite2D:
	get:
		return $Icon

@onready var size: float:
	get:
		return shape.size
	set(value):
		shape.size = value

var type: TileInfo.TerrainType:
	set(value):

		type = value

		match type:
			TileInfo.TerrainType.Basic:
				shape.modulate = Color.LIGHT_GREEN
				icon.texture = preload ("res://assets/img/grass.png")
			TileInfo.TerrainType.Water:
				shape.modulate = Color.LIGHT_BLUE
				icon.texture = preload ("res://assets/img/wave.png")
			TileInfo.TerrainType.Mountain:
				shape.modulate = Color.ROSY_BROWN
				icon.texture = preload ("res://assets/img/mountain.png")
		
		baseModulate = shape.modulate

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
			
		if value == null:
			tooltip.text = ""
		else:
			tooltip.text = placementBonus.rules_text()
		
		if tooltip.text.length() > 0:
			$PlacementBonus.visible = true

var placedStructure: PlacedStructure

var isHovered: bool
var baseModulate: Color

func has_structure() -> bool:
	return placedStructure != null

func has_placement_bonus() -> bool:
	return placementBonus != null

func get_neighbours() -> Array[Tile]:
	var neighbours: Array[Tile] = []

	for nCoord in coordinates.get_neighbours():
		var n = map.get_tile(nCoord)

		if (n != null):
			neighbours.push_back(n)

	return neighbours

func get_relative_tile(displacement: Vector2i) -> Tile:
	var targetCoords = coordinates.add_vec(displacement)
	return map.get_tile(targetCoords)

func get_rotated_tile(rotationSteps: int) -> Tile:
	var rotatedCoords = coordinates.get_rotated(rotationSteps)
	return map.get_tile(rotatedCoords)

func is_corner() -> bool:
	return Utils.is_corner_tile(self, map.radius)

func is_edge() -> bool:
	return Utils.is_edge_tile(self, map.radius)

func _physics_process(_delta: float) -> void:
	if isHovered:
		shape.modulate = baseModulate * (pingpong(Time.get_ticks_msec() / 1000.0, 1.0) + .5)
	else:
		shape.modulate = baseModulate

func _ready() -> void:
	assert(map != null)
	scale = Vector2.ONE * .2
	create_tween().tween_property(self, 'scale', Vector2.ONE, .2)
	shape.clicked.connect(_on_tile_pressed)
	shape.hovered.connect(_on_tile_hovered)
	Debug.toggled.connect(func(on): $Debug.visible=on)

func _on_tile_pressed() -> void:
	onClicked.emit(self)
func _on_tile_hovered(state: bool) -> void:
	if (state):
		onHovered.emit(self)
	
	isHovered = state

	if tooltip.text.length() > 0:
		tooltip.visible = state
	else:
		tooltip.visible = false
	$Debug/Hovered.visible = state

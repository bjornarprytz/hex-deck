class_name Tile
extends Node2D


enum TerrainType {
	Basic,
	Water,
	Mountain
}

@onready var shape :RegularPolygon = $Shape

@onready var size: float:
	get:
		return shape.size

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

var structure : Structure

func _ready() -> void:
	shape.clicked.connect(_on_tile_pressed)
	shape.hovered.connect(_on_tile_hovered)

func _on_tile_pressed() -> void:
	Events.tileClicked.emit(self)
func _on_tile_hovered(state:bool) -> void:
	if (state):
		Events.tileHovered.emit(self)
	
	$Debug/Hovered.visible = state

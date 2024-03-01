class_name Tile
extends Node2D

@onready var shape :RegularPolygon = $Shape

enum TerrainType {
	Basic,
	Water,
	Mountain
}

var coordinates: Map.Coordinates:
	set(value):
		coordinates = value
		
		$Debug/Q.text = str(coordinates.q)
		$Debug/R.text = str(coordinates.r)
		$Debug/S.text = str(coordinates.s)

@onready var size: int:
	get:
		return shape.size

@onready var type: TerrainType:
	set(value):
		
		type = value
		
		match type:
			TerrainType.Basic:
				modulate = Color.SEA_GREEN
			TerrainType.Water:
				modulate = Color.LIGHT_BLUE
			TerrainType.Mountain:
				modulate = Color.ROSY_BROWN
			

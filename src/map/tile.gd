class_name Tile
extends Node2D

@onready var shape :RegularPolygon = $Shape


var coordinates: Map.Coordinates:
	set(value):
		coordinates = value
		
		$Q.text = str(coordinates.q)
		$R.text = str(coordinates.r)
		$S.text = str(coordinates.s)



@onready var size: int:
	get:
		return shape.size


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

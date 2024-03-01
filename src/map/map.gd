class_name Map
extends Node2D

class Coordinates:
	## North-South line
	var q: int
	## UpperLeft-LowerRight line
	var r: int
	## LowerLeft-UpperRight line
	var s: int
	
	func _init(q, r):
		self.q = q
		self.r = r
		self.s = -q -r
	
	func get_key() -> String:
		return str(q) + "," + str(r)

@export var size: int:
	set(value):
		if (value < 1):
			value = 1
		if size == value:
			return
		size = value
		_update_map.call_deferred()

@onready var tile_spawner = preload("res://map/tile.tscn")

var tiles : Dictionary = {}

func get_tile(coords: Coordinates) -> Tile:
	return tiles[coords.get_key()]

func _update_map():
	for child in get_children():
		child.queue_free()
		
	for q in range(size):
		for r in range(size):
			_add_tile(-q, r)
			_add_tile(q, -r)
			
			if abs(q+r) >= size:
				continue
			
			_add_tile(q, r)
			if (q != 0 or r != 0):
				_add_tile(-q, -r)
	
func _add_tile(q: int, r: int):
	var coords = Coordinates.new(q, r)
	var key = coords.get_key()
	
	if tiles.has(key):
		return
	
	var new_tile = tile_spawner.instantiate() as Tile
	new_tile.coordinates = coords
	
	tiles[key] = new_tile
	
	add_child(new_tile)
	new_tile.position = axial_to_pixel(q, r, new_tile.size)
	
static func axial_to_pixel(q:int,r:int,tile_size:int) -> Vector2:
	var x :float = tile_size * 3/2 * q
	var y :float = tile_size * sqrt(3) * (r + q/2.0)
	return Vector2(x, y)

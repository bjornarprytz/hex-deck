class_name Map
extends Node2D

class Coordinates:
	## North-South line
	var q: int
	## UpperLeft-LowerRight line
	var r: int
	## LowerLeft-UpperRight line
	var s: int
	
	func _init(qq, rr):
		q = qq
		r = rr
		s = -qq -rr
	
	func get_key() -> String:
		return str(q) + "," + str(r)
	
	func add_coord(other: Coordinates) -> Coordinates:
		return Coordinates.new(q + other.q, r + other.r)
	func add_vec(vec: Vector2i) -> Coordinates:
		return Coordinates.new(q + vec.x, r + vec.y)
		

@export var size: int:
	set(value):
		if (value < 1):
			value = 1
		if size == value:
			return
		size = value
		_update_map.call_deferred()

@onready var tile_spawner = preload("res://map/tile.tscn")
@onready var structureSpawner = preload("res://map/placed_structure.tscn")
@onready var structures = $Structures
@onready var tiles = $Tiles

var tilesLookup : Dictionary = {}

func get_tile(coords: Coordinates) -> Tile:
	var key = coords.get_key()
	if tilesLookup.has(key):
		return tilesLookup[key]
	return null

func get_tile_from_mouse_pointer() -> Tile:
	var coords = point_to_coords(get_local_mouse_position())
	return get_tile(coords)

func place_structure(structure: Structure, affectedTiles: Array[Tile]):
	var placedStructure = structureSpawner.instantiate() as PlacedStructure
	placedStructure.structure = structure
	structures.add_child(placedStructure)
	
	placedStructure.position = affectedTiles[0].position
	
	for tile in affectedTiles:
		tile.structure = placedStructure.structure

func _update_map():
	for tile in tiles.get_children():
		tile.queue_free()
		
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
	
	if tilesLookup.has(key):
		return
	
	var new_tile = tile_spawner.instantiate() as Tile
	new_tile.coordinates = coords
	
	new_tile.type = Tile.TerrainType.values().pick_random()
	
	tilesLookup[key] = new_tile
	
	tiles.add_child(new_tile)
	new_tile.position = Map.axial_to_pixel(q, r, new_tile.size)

func point_to_coords(point: Vector2) -> Coordinates:
	var q = ( 2.0/3.0 * point.x                        ) / tilesLookup["0,0"].size
	var r = (-1.0/3.0 * point.x  +  sqrt(3)/3.0 * point.y) / tilesLookup["0,0"].size
	return Map.cube_round(Coordinates.new(q, r))

static func axial_to_pixel(q:int,r:int,tileSize:int) -> Vector2:
	var x :float = tileSize * 3.0/2.0 * q
	var y :float = tileSize * sqrt(3) * (r + q/2.0)
	return Vector2(x, y)


static func cube_round(frac : Coordinates) -> Coordinates:
	var q = round(frac.q)
	var r = round(frac.r)
	var s = round(frac.s)

	var q_diff = abs(q - frac.q)
	var r_diff = abs(r - frac.r)
	var s_diff = abs(s - frac.s)

	if q_diff > r_diff and q_diff > s_diff:
		q = -r-s
	elif r_diff > s_diff:
		r = -q-s
	else:
		s = -q-r

	return Coordinates.new(q, r)

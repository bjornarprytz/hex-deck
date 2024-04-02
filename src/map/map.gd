class_name Map
extends Node2D

class Coordinates:
	## North-South line
	var q: int
	## UpperLeft-LowerRight line
	var r: int
	## LowerLeft-UpperRight line
	var s: int
	
	var _neighbours: Array[Coordinates]

	func _init(qq, rr):
		q = qq
		r = rr
		s = -qq - rr

	static func from_vec(vec: Vector2i) -> Coordinates:
		return Coordinates.new(vec.x, vec.y)

	func get_neighbours() -> Array[Coordinates]:
		if _neighbours != null:
			_neighbours = []
			for nVec in Utils.get_axial_neighbors(Vector2i(q, r)):
				_neighbours.push_back(Coordinates.from_vec(nVec))
		
		return _neighbours
		
	func get_key() -> String:
		return str(q) + "," + str(r)
	func add_coord(other: Coordinates) -> Coordinates:
		return Coordinates.new(q + other.q, r + other.r)
	func add_vec(vec: Vector2i) -> Coordinates:
		return Coordinates.new(q + vec.x, r + vec.y)
	func to_vec() -> Vector2i:
		return Vector2i(q, r)

signal tileHovered(tile: Tile)
signal tileClicked(tile: Tile)

@export var tileSize: float:
	set(value):
		if value <= 1.0:
			value = 1.0
		if tileSize == value:
			return
		tileSize = value

@onready var structures = $Structures
@onready var tiles = $Tiles

@onready var radius: int = Meta.settings.mapRadius
@onready var tilePool = Meta.settings.get_terrain_pool()

## Key -> Tile
var tilesLookup: Dictionary = {}
## Key -> Coordinate
var undiscoveredTiles: Dictionary = {}

func _ready() -> void:
	_initialize_map()

func get_placed_structures() -> Array[PlacedStructure]:
	var result: Array[PlacedStructure] = []

	for c in structures.get_children():
		if c is PlacedStructure:
			result.push_back(c)

	return result

func get_tiles() -> Array[Tile]:
	var result: Array[Tile] = []

	for c in tiles.get_children():
		if c is Tile:
			result.push_back(c)

	return result

## Add tile to the edge of the map, mute the returned tile to configure it
func discover_tile(coords: Coordinates) -> Tile:
	assert(undiscoveredTiles.has(coords.get_key()))
	
	return _add_tile(coords.q, coords.r)

func get_tile(coords: Coordinates) -> Tile:
	var key = coords.get_key()
	if tilesLookup.has(key):
		return tilesLookup[key]
	return null

func get_tile_from_mouse_pointer() -> Tile:
	var coords = point_to_coords(get_local_mouse_position())
	return get_tile(coords)

func place_structure(structure: Structure, affectedTiles: Array[Tile]) -> PlacedStructure:
	var placedStructure = Create.placedStructure(structure)
	structures.add_child(placedStructure)
	
	placedStructure.position = affectedTiles[0].position
	placedStructure.affectedTiles = affectedTiles
	
	for tile in affectedTiles:
		tile.placedStructure = placedStructure
	
	return placedStructure

func _initialize_map():
	for q in range(radius):
		for r in range(radius):
			_add_tile( - q, r)
			_add_tile(q, -r)
			
			if abs(q + r) >= radius:
				continue
			
			_add_tile(q, r)
			if (q != 0 or r != 0):
				_add_tile( - q, -r)
	
func _add_tile(q: int, r: int) -> Tile:
	var coords = Coordinates.new(q, r)
	var key = coords.get_key()
	
	if tilesLookup.has(key):
		return null
	
	undiscoveredTiles.erase(key)
	for n in coords.get_neighbours():
		var nKey = n.get_key()
		if !tilesLookup.has(nKey):
			undiscoveredTiles[nKey] = n

	var newTile = Create.tile(_random_tile_data())
	newTile.coordinates = coords
	newTile.map = self
	
	tilesLookup[key] = newTile
	
	newTile.position = Utils.axial_to_pixel(q, r, tileSize)
	newTile.size = tileSize
	newTile.onHovered.connect(_on_tile_hovered)
	newTile.onClicked.connect(_on_tile_clicked)
	
	tiles.add_child(newTile)

	return newTile

func point_to_coords(point: Vector2) -> Coordinates:
	var q = (2.0 / 3.0 * point.x) / tileSize
	var r = (-1.0 / 3.0 * point.x + sqrt(3) / 3.0 * point.y) / tileSize
	return Utils.cube_round(Coordinates.new(q, r))

func _on_tile_hovered(tile: Tile):
	tileHovered.emit(tile)
func _on_tile_clicked(tile: Tile):
	tileClicked.emit(tile)

func _random_tile_type() -> TileInfo.TerrainType:
	var total = 0

	var inTheRunning = tilePool.keys()

	for type in tilePool.keys():
		var subTotal = tilePool[type]
		if subTotal == 0:
			inTheRunning.erase(type)
		
		total += subTotal
	
	var index = randi_range(0, total)

	for type in inTheRunning:
		index -= tilePool[type]
		if (index <= 0):
			tilePool[type] -= 1
			return type
	
	print("Ran out of index, returning random tile")
	return TileInfo.TerrainType.values().pick_random()

func _random_tile_data() -> TileInfo:
	var type = _random_tile_type()
	var placementBonus: PlacementBonus = null
	if (type == TileInfo.TerrainType.Basic and randf() < .2):
		placementBonus = PlacementBonus.new([Meta.placementBonuses.pick_random()])
	
	return TileInfo.new(type, placementBonus)
